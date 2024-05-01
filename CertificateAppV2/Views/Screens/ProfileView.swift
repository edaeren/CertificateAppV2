//
//  ProfileView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 19.04.2024.
//

import SwiftUI

struct ProfileView: View {
    @State var showSettings: Bool = false
    @State var profileDisplayName: String
    var profileUserID: String
    
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false, content:{
            ProfileHeaderView(profileDisplayName: $profileDisplayName, profileImage: $profileImage)
            HStack{
                Text("User's Certificates will be here inside of a hstack")
            }
        })
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:

            Button(action: {
            showSettings.toggle()
            },
            label: {
                Image(systemName: "gear")
            })
                .accentColor(Color.MyTheme.pinkColor)
        )
        .onAppear(perform: {
            getProfileImage()
        })
        .sheet(isPresented: $showSettings, content: {
            SettingsView()
        })
    }
    
    //MARK: FUNCTIONS
    
    func getProfileImage(){
        ImageManager.instance.downloadProfileImage(userID: profileUserID) { (returnedImage) in
            if let image = returnedImage {
                self.profileImage = image
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider{
    static var previews: some View{
        NavigationView{
            ProfileView(profileDisplayName:"joe", profileUserID: "")
        }
    }
}
