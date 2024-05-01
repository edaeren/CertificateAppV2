//
//  ShortFormView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 1.05.2024.
//

import SwiftUI

struct ShortFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var submissionText: String = ""
    @State var placeholder: String = "Please enter the link.."
    
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
            
        }//hstack
        ScrollView(.vertical){
            Text("FORM PAGE")
            
            TextField(placeholder, text: $submissionText)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.secondary)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Save".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 45)
                    .frame(maxWidth: 100)
                    .background(Color.gray)
                    .cornerRadius(12)
            })
            .accentColor(Color.black)
            
            
        } //scroll view
       
    } //body view
}//endis view

#Preview {
        ShortFormView()
    
              
}
