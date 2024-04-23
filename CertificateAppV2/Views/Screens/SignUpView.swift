//
//  SignUpView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 23.04.2024.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20, content: {
            
            Spacer()
            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("You are not signed in!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.white)
            
            Text("Click the button below to create an account!")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            
            Button(action:{
                
            }  , label: {
                Text("Sign In  / Sign Up".uppercased())
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.pinkColor)
                    .cornerRadius(12)
                    .shadow(radius: 12)
            })
            .accentColor(.black)
            .padding()
            
            Spacer()
        })

        .padding(.all, 40)
        .background(Color.MyTheme.blueColor)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SignUpView()
}
