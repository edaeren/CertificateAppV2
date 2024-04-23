//
//  ContentView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 13.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    var currentUserId: String? = nil
    
    var body: some View {
        TabView {
            //feed view yazisinin gozukmesi icin navigation view icine aldik feed view u
            NavigationView{
              //  FeedView(datas: DataArrayObject(),section1: DataArrayObject())
                FeedView(section1: DataArrayObject(), section2: DataArrayObject())
            }
                .tabItem {
                    Image(systemName: "rosette")
                    Text("Home Page")
                }
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            Text("Form")
                .tabItem {
                    Image(systemName: "book.pages")
                    Text("Form")
                }
            
            //ztack is for showing the page if the user is signed in
            //tab item should follow the zstack for not getting a crush
            ZStack{
                if currentUserId != nil {
                    NavigationView{
                        ProfileView()
                    }
                } else {
                    SignUpView()
                }
               
            }
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .accentColor(Color.MyTheme.pinkColor)
    }
}

#Preview {
    ContentView()
}
