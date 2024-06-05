//
//  AssignJuryView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 5.06.2024.
//

import SwiftUI

struct AssignJuryView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
       /*
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .fontWeight(.medium)

            })
            .accentColor(.black)
            .padding(.all, 20)
            .padding(.leading)
            Spacer()
            
        }//hstack*/
        ScrollView{
            Text("Admin will assign juries here")
        }
        
    }
}

#Preview {
    AssignJuryView()
}
