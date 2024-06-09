//
//  SettingsView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 19.04.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showSignOutError: Bool = false
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false, content: {
                
                // MARK: SECTION 1: CERTIFICATE APP
                GroupBox(label: SettingsLabelView(labelText: "CertificateApp", labelImage: "dot.radiowaves.left.and.right"), content: {
                    HStack(alignment: .center, spacing: 10, content: {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80, alignment: .center)
                            .cornerRadius(12)
                        Text("Certificate App is the #1 app for getting the certifates that you need for your career!")
                            .font(.footnote)
                    })
                })
                .padding()
                
                // MARK: SECTION2: PROFILE
                GroupBox(label: SettingsLabelView(labelText: "Profile", labelImage: "person.fill"), content: {
                    
                    NavigationLink(
                        destination:SettingsEditTextView(submissionText: "Current Display Name", title: "Display Name", description: "You can edit your display name here.", placeholder: "Your display name here.."),
                        label: {
                            SettingsRowView(leftIcon: "pencil", text: "Display Name", color: Color.MyTheme.blueColor)
                        }
                    )
                    
                    NavigationLink(
                        destination: SettingsEditTextView(submissionText: "Current bio here", title: "Profile Bio", description: "Let other users know about you.", placeholder: "Your bio here.."),
                        label:{
                            SettingsRowView(leftIcon: "text.quote", text: "Bio", color: Color.MyTheme.blueColor)
                        })
                  
                    SettingsRowView(leftIcon: "photo", text: "Profile Picture", color: Color.MyTheme.blueColor)
                    
                    Button(action: {
                       signOut()
                    }, label: {
                        SettingsRowView(leftIcon: "figure.walk", text: "Sign Out", color: Color.MyTheme.blueColor)
                    }).alert(isPresented: $showSignOutError, content: {
                        return Alert(title: Text("Error signing out"))
                    })
                   
                })
                .padding()
                
                // MARK: SECTION3 :APPLICATION
                GroupBox(label: SettingsLabelView(labelText: "Application", labelImage: "apps.iphone"), content: {
                    SettingsRowView(leftIcon: "folder.fill", text: "Privacy Policy", color: Color.MyTheme.YellowColor)
                    SettingsRowView(leftIcon: "folder.fill", text: "Terms And Conditions", color: Color.MyTheme.YellowColor)
                    SettingsRowView(leftIcon: "globe", text: "Certificate App's Website", color: Color.MyTheme.YellowColor)
                })
                .padding()
                
                // MARK: SECTION4: SIGN OFF
                GroupBox {
                    Text("All Rights Reserved \n Copyright 2024 📝")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }.padding()
                    .padding(.bottom, 80)
            })
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading:
                Button(action: {
                presentationMode.wrappedValue.dismiss()
                
            },
                label: {
                   Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(Color.primary)
            }).accentColor(.primary)
            )
        }
       
    }
    
    func signOut(){
        AuthService.instance.logOutUser { (success) in
            if success {
                print("Successfully logged out")
                
                //Dismiss setting view
                self.presentationMode.wrappedValue.dismiss()
                
                //Update userdefaults
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    
                    //kaydedilmiş bütün bilgileri getirir
                    let defaulsDictionary = UserDefaults.standard.dictionaryRepresentation()
                    //tek tek hepsini siler
                    defaulsDictionary.keys.forEach {(key) in
                        UserDefaults.standard.removeObject(forKey: key)
                    }
                    
                }
            } else {
                print("Error login out")
                self.showSignOutError.toggle()
            }
        }
    }
}

#Preview {
        SettingsView()
}
