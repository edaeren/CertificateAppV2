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
    var body: some View {
       
            List{
                ForEach(listOfCertificates.dataArray, id: \.self){ certificates in
                    HStack{
                        Text(certificates.certificateName.capitalized)
                        Spacer()
                    }
                    .padding()
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Search")
        
        
    }
}

#Preview {
    NavigationView{
        SearchView(listOfCertificates: DataArrayObject())
    }
    
}
