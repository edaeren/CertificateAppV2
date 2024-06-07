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
    @State var isAdminModel = UserModel(userID: "", userName: "", isAdmin: false, isJury: false)
    @State var isAdmin: Bool = false
    /*
    init() {
           checkUserState()
       }*/
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
//            checkUserState()
            
            if isAdmin {
                          NavigationView {
                              ApplicantsView()
                          }
                          .tabItem {
                              Image(systemName: "book.pages")
                              Text("Applicants")
                          }
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
        .onAppear {
        }
    }
   
    //MARK: FUNCTIONS
    //checking if the user is admin or not
    /*
    func checkUserState(){
        AuthService.instance.getUserStateInfo(forUserID: isAdminModel.userID) {
            (returnedUserState) in
           /* let userState = returnedUserState
            return userState*/
            
            if let userState = returnedUserState{
                self.isAdmin = isAdmin
            }
        }
    }*/
    func checkUserState(completion: @escaping (Bool) -> Void) {
            AuthService.instance.getUserStateInfo(forUserID: isAdminModel.userID) { (returnedUserState) in
                if let userState = returnedUserState {
                    completion(userState)
                } else {
                    completion(false)
                }
            }
        }
    
    
}

#Preview {
    ContentView()
}
