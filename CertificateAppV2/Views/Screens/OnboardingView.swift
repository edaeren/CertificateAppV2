//
//  OnboardingView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 23.04.2024.
//

import SwiftUI
import FirebaseAuth

struct OnboardingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showOnboardingPart2: Bool = false
    @State var showOnboardingMail: Bool = false
    @State var showError: Bool = false
    
    @State var displayName: String = ""
    @State var email :String = ""
    @State var password :String = ""
    @State var providerID: String = ""
    @State var provider : String = ""
    
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
            
            //MARK: SIGN IN WITH APPLE
            Button(action: {
                SignInWithApple.instance.startSignInWithAppleFlow(view: self)
            }, label: {
                SignInWithAppleButtonCustom()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
            })
            
            //MARK: SIGN IN WITH GOOGLE
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
            
            
            //MARK: SIGN UP WITH MAIL
            Button(action: {
                showOnboardingMail.toggle()
            }, label: {
                HStack{
                    Image(systemName: "mail")
                    Text("Sign Up")
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color(.sRGB, red:100/255, green: 200/255, blue: 100/255, opacity: 1.0))
                .cornerRadius(4)
                .font(.system(size: 23, weight: .medium, design: .default))
            })
            .accentColor(Color.white)
            
            
            //MARK: LOGIN
            TextField("Email", text: $displayName)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
                .padding(.horizontal)
            TextField("Password", text: $displayName)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
                .padding(.horizontal)
            
            Button(action: {
                showOnboardingMail.toggle()
            }, label: {
                HStack{
                    //Image(systemName: "mail")
                    Text("Login")
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                .cornerRadius(4)
                .font(.system(size: 23, weight: .medium, design: .default))
            })
            .accentColor(Color.white)
            
            
            Text("or")
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
        .fullScreenCover(isPresented: $showOnboardingPart2, onDismiss: {
            self.presentationMode.wrappedValue.dismiss()
        }, content: {
            OnboardingViewPart2(displayName: $displayName, email: $email,password: $password, providerID: $providerID, provider: $provider)
        })
        .fullScreenCover(isPresented: $showOnboardingMail, onDismiss: {
            self.presentationMode.wrappedValue.dismiss()
        }, content: {
            OnboardingViewMail(displayName: $displayName, email: $email,password: $password, providerID: $providerID, provider: $provider)
        })
        
        .alert(isPresented: $showError, content: {
            return Alert(title: Text("Error signin in 😭"))
        })
    }
    
    // MARK: FUNCTIONS
    func connectToFirebase(name: String,email: String, provider: String, credential: AuthCredential){
        AuthService.instance.logInUserToFirebase(credential: credential) { returnedProviderId, isError in
                
            if let provierID = returnedProviderId, !isError {
                
                self.displayName = name
                self.email = email
                self.providerID = provierID
                self.provider = provider
                
                self.showOnboardingPart2.toggle()
                
            } else{
                print("Error getting in to from log in user Firebase")
                self.showError.toggle()
            }
        }
    }
    
    /*
    func cpenProfile(){
     //   AuthService.instance.logInUserToApp(userID: String, handler: <#T##(Bool) -> ()##(Bool) -> ()##(_ success: Bool) -> ()#>) { //(returnedUserId) in
            
           // if let userID = returnedUserId{
                //Success
              //  print("Successfully found user in database")
                AuthService.instance.logInUserToApp(userID: userID) {(success) in
                    if success{
                        print("User logged in!")
                        //return to app
                        self.presentationMode.wrappedValue.dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }else{
                        print("Error logging in")
                        self.showError.toggle()
                    }
                }
            }else{
                //Error
                print("Error matching user in Database")
                self.showError.toggle()
            }
        }*/
    }
    

#Preview {
    OnboardingView()
}

/******************************************************************************************************/
