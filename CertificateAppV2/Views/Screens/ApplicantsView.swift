//
//  JuryAssignmentView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 26.04.2024.
//

import SwiftUI

struct ApplicantsView: View {
    //this list will be the applicant list
    @ObservedObject var listOfApplicants : DataArrayObject
    @State var searchText = ""
//    @State var showAssignJuryPage: Bool = false
    var filteredCert: [CertificateModel] {
            if searchText.isEmpty {
                return listOfApplicants.dataArray
            } else {
                return listOfApplicants.dataArray.filter { $0.certificateName.localizedCaseInsensitiveContains(searchText) }
            }
        }
    
    var body: some View {
        NavigationStack{
            List(filteredCert, id: \.self) { certificate in
            
                //buradan da assignment page'ine gitmeli jurileri burada atayacak admin.
                //gidiş navigationstack değil de pop up page olsun
                
                NavigationLink(destination: {
                    AssignJuryView()
//                    CertificateView(certificates: certificate)
                }, label: {
                    HStack {
                        Text(certificate.certificateName.capitalized)
                        Spacer()
                    }
                })
               
               
            }
//            .searchable(text: $searchText, prompt: "Search certificates")
            .navigationTitle("Applicants")
        }
        /*
        .fullScreenCover(isPresented: $showAssignJuryPage, content: {
            AssignJuryView()
        })*/
    }
}

#Preview {
    NavigationView{
        ApplicantsView(listOfApplicants: DataArrayObject())
    }
    
}
