//
//  OnboardingViewMail.swift
//  CertificateAppV2
//
//  Created by Taha  Adıgüzel on 2.05.2024.
//

import Foundation
import SwiftUI

struct OnboardingViewMail: View {
    
    @Binding var displayName: String
    @Binding var email :String
    @Binding var password : String 
    @Binding var providerID: String
    @Binding var provider : String
    @State var showImagePicker: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    //for image picker
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State var showError: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20, content: {
            Text("What's your name?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
            TextField("Add your name here...", text: $displayName)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
                .padding(.horizontal)
            
            TextField("Add your mail here...", text: $email)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(12)
                .font(.headline)
                .padding(.horizontal)
            
            TextField("Add your pasword here...", text: $password)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(12)
                .font(.headline)
                .padding(.horizontal)
            
            Button(action: {
                showImagePicker.toggle()
            },label: {
                Text("Finish: Add profile picture")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.pinkColor)
                    .cornerRadius(12)
                    .padding(.horizontal)
                
            })
            .accentColor(.black)
            .opacity(displayName != "" ? 1.0 : 0.0)
            .animation(Animation.easeInOut(duration: 1.0),value: UUID())
            
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Not Now")
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding()
            })
            .accentColor(.black)
         
        })
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.MyTheme.blueColor)
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showImagePicker,onDismiss: createProfile, content: {
            ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
        })
        .alert(isPresented: $showError) { () -> Alert in
            return Alert(title: Text("Error creating profile 😭"))
        }
    }
    
    // MARK: FUNCTIONS
    
    func createProfile(){
        print("CREATE PROFILE NOW")
        AuthService.instance.createNewUserInDatabase(name: displayName, email: email, password: password, providerID: providerID, provider: "mail", profileImage: imageSelected) { (returnedUserId) in
            
            if let userID = returnedUserId{
                //Success
                print("Successfully created new user in database")
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
                print("Error creating user in Database")
                self.showError.toggle()
            }
        }
    }
    
    
    
}

struct OnboardingViewMails_Previews: PreviewProvider {
    
    @State static var testString: String = "Test"
    
    static var previews: some View {
        OnboardingViewMail(displayName: $testString, email: $testString, password: $testString ,providerID: $testString, provider: $testString)
    }
}
