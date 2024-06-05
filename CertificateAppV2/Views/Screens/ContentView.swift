//
//  ContentView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 13.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentDisplayName :String?
    var currentUserId: String? = nil
    
    var body: some View {
        TabView {
            //feed view yazisinin gozukmesi icin navigation view icine aldik feed view u
            NavigationView{
              //  FeedView(datas: DataArrayObject(),section1: DataArrayObject())
                FeedView(section1: DataArrayObject(), section2: DataArrayObject(), section3: DataArrayObject())
            }
                .tabItem {
                    Image(systemName: "rosette")
                    Text("Home Page")
                }
            NavigationView{
                SearchView(listOfCertificates: DataArrayObject())
            }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            /*  form page
            Text("Form")
                .tabItem {
                    Image(systemName: "book.pages")
                    Text("Form")
                }*/
        //------------------------------------------------------------------------------------------------
            
            //burasi yalnizca admine gorunmeli
            NavigationView{
                ApplicantsView(listOfApplicants: DataArrayObject())
            }
                .tabItem {
                    Image(systemName: "book.pages")
                    Text("Applicants")
                }
            //------------------------------------------------------------------------------------------------
            
            
            //ztack is for showing the page if the user is signed in
            //tab item should follow the zstack for not getting a crush
            ZStack{
                if let userID = currentUserID, let displayName = currentDisplayName {
                    NavigationView{
                        ProfileView(profileDisplayName: displayName, section1:DataArrayObject(), profileUserID: userID)
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
