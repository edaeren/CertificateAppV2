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
                .font(.title)
                .padding(.bottom,50)
            Spacer()
            Spacer()
            Text("Please enter the link to your video (which shows us that you provide all the required things to get this certificate!) to the text field for our jury to evaluate your request.")
                .padding(.bottom,30)
                .frame(maxWidth: 350)
            Spacer()
            TextField(placeholder, text: $submissionText)
                .padding()
                .frame(height: 50)
                .frame(maxWidth: 350)
                .background(Color.MyTheme.pinkColor)
//                .background(Color.white)
//                .border(Color.black)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
            
            Spacer()
            Button(action: {
                //eger butona basildiysa istek listesine kisinin istegi dusmeli
                
                
            }, label: {
                Text("Apply!".uppercased())
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding()
                    .frame(height: 40)
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
