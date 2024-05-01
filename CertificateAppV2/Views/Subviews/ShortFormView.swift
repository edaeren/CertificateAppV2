//
//  ShortFormView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 1.05.2024.
//

import SwiftUI

struct ShortFormView: View {
    @Environment(\.presentationMode) var presentationMode
  
    
    var body: some View {
      
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
        }
        ScrollView(.vertical){
            Text("FORM PAGE")
        }
       
    }
}

#Preview {
    ShortFormView()
}
