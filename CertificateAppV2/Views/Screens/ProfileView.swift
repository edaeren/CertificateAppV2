//
//  ProfileView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 19.04.2024.
//

import SwiftUI

struct ProfileView: View {
    @State var showSettings: Bool = false
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false, content:{
            ProfileHeaderView()
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
        .sheet(isPresented: $showSettings, content: {
            SettingsView()
        })
       
      
    }
}

#Preview {
    NavigationView{
        ProfileView()
    }
   
}
