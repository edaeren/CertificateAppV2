//
//  OnboardingView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 23.04.2024.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showOnboardingPart2: Bool = false
    
    var body: some View {
        VStack(spacing: 10){
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
                .shadow(radius: 12)
            
            Text("Welcome To Certificate App!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color.black)
            
            Text("Certificate App is the #1 app for getting the certifates that you need for your career!")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.black)
                .padding()
            
            Button(action: {
                showOnboardingPart2.toggle()
            }, label: {
                SignInWithAppleButtonCustom()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
            })
            
            Button(action: {
                showOnboardingPart2.toggle()
            }, label: {
                HStack{
                    Image(systemName: "globe")
                    Text("Sign in with Google")
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color(.sRGB, red:222/255, green: 82/255, blue: 70/255, opacity: 1.0))
                .cornerRadius(4)
                .font(.system(size: 23, weight: .medium, design: .default))
            })
            .accentColor(Color.white)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            },
                   label: {
                Text("Continue as guest".uppercased())
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding()
            })
            .accentColor(.black)
            
            
            
        }
        .padding(.all,20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.MyTheme.blueColor)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $showOnboardingPart2, content: {
            OnboardingViewPart2()
        })
    }
}

#Preview {
    OnboardingView()
}
