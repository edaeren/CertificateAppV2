//
//  SettingsEditTextView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 23.04.2024.
//

import SwiftUI

struct SettingsEditTextView: View {
    @State var submissionText: String = ""
    @State var title: String
    @State var description: String
    @State var placeholder: String
    var body: some View {
        VStack{
            HStack{
                Text(description)
                Spacer(minLength: 0)
            }
          
            
            TextField(placeholder, text: $submissionText)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.MyTheme.pinkColor)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Save".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.blueColor)
                    .cornerRadius(12)
            })
            .accentColor(Color.black)
            
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationBarTitle(title)
    }
}

#Preview {
    NavigationView{
        SettingsEditTextView(title: "Test Title", description: "This is a description", placeholder: "Test placeholder")
    }
    
}
