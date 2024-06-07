//
//  SearchView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 26.04.2024.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var listOfCertificates : DataArrayObject
    @State var searchText = ""
    var filteredCert: [CertificateModel] {
            if searchText.isEmpty {
                return listOfCertificates.dataArray
            } else {
                return listOfCertificates.dataArray.filter { $0.certificateName.localizedCaseInsensitiveContains(searchText) }
            }
        }
   // var filteredCert : [listOfCertificates.dataArray]
    
    var body: some View {
        NavigationStack{
            List(filteredCert, id: \.self) { certificate in
            
                NavigationLink(destination: {
                    CertificateView(certificates: certificate)
                }, label: {
                    HStack {
                        Text(certificate.certificateName.capitalized)
                        Spacer()
                    }
                })
               
            }
            
            
            
            
            /*
            List(filteredCert, id: \.self) { certificate in
            
                HStack {
                    Text(certificate.certificateName.capitalized)
                    Spacer()
                }
            }*/
                
            
            .searchable(text: $searchText, prompt: "Search certificates")
            .navigationTitle("Search")
        }
 
        
    }
}

#Preview {
    NavigationView{
        SearchView(listOfCertificates: DataArrayObject(forUserID: ""))
    }
    
}
