//
//  ShowAllCertificatesView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 9.06.2024.
//

import Foundation
import SwiftUI

struct ShowAllCertificatesView: View {
    @Environment(\.presentationMode) var presentationMode
    var sectionID: String
    @ObservedObject var dataArrayObject: DataArrayObject
    @State private var gridItemWidth: CGFloat = 150
    @State private var spacing: CGFloat = 10 // Initial spacing between grid items
    let columns = [
           GridItem(.flexible(minimum: 150), spacing: 10),
           GridItem(.flexible(minimum: 150), spacing: 10)
       ]
    var body: some View {
      
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.primary)

            })
            .accentColor(.black)
            .padding(.all, 20)
            .padding(.leading)
            Spacer()
            
        }//hstack
//        Spacer()
        NavigationView {
            VStack {
                Text("All Certificates In This Section")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .frame(width: 270)
                    .padding(.leading,10)
                if dataArrayObject.dataArray.isEmpty {
                    ProgressView() // Show loading indicator if data is not yet available
                } else{
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(dataArrayObject.dataArray.filter { $0.sectionID == sectionID }, id: \.self) { data in
                                NavigationLink(destination: CertificateView(certificates: data)) {
                                    MiniCertificateView(data: data)
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150)
                                        .background(Color(.clear))
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true) // Hide the navigation bar
        }
       
    } //body view
    
    //MARK: FUNCTIONS
}//endis view

#Preview {
    NavigationView{
//        ShowAllCertificatesView(sectionID: "1", dataArrayObject: DataArrayObject(forUserID:""))
        let sampleDataArray = DataArrayObject(forUserID: "")
               sampleDataArray.dataArray = [CertificateModel(certificateID: "1", certificateName: "Certificate 1", sectionID: "1", sectionName: "Section 1"),
                                            CertificateModel(certificateID: "2", certificateName: "Certificate 2", sectionID: "1", sectionName: "Section 1"),
                                            CertificateModel(certificateID: "3", certificateName: "Certificate 3", sectionID: "2", sectionName: "Section 2")]
               return ShowAllCertificatesView(sectionID: "1", dataArrayObject: sampleDataArray)
    }
}
