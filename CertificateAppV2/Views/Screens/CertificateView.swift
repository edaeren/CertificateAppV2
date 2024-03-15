//
//  CertificateView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 15.03.2024.
//

import SwiftUI

struct CertificateView: View {
    var body: some View {
        VStack{
            ScrollView{
                Image("food1")
                    .resizable()
                    .scaledToFill()
                    //.frame(width: 390, height: 250, alignment: .center)
                    .frame(width: 295, height: 250, alignment: .center)
                    .padding(.all,50) .padding(.horizontal,106)
                Text("Placeholder")
                Text("Placeholder")
                Text("Placeholder")
                Text("Placeholder")
            }
        }
        /*HStack{
            Image("certificate1")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
        }*/
    }
}

#Preview {
    CertificateView()
}
