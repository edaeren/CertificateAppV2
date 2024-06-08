//
//  UserArrayObject.swift
//  userAppV2
//
//  Created by Eda Eren on 5.06.2024.
//

import Foundation
class UserArrayObject: ObservableObject{
    @Published var userArray = [UserModel]()
    @Published var section1Array = [UserModel]()
    @Published var section2Array = [UserModel]()
    @Published var section3Array = [UserModel]()
    
    init(){
        /*
        print("fetch from database here")
        
        let user1 = UserModel(userID: "1", userName: "user1", isAdmin:false, isJury:false ,email:"", sectionID: "1", sectionName: "Yemekle İlgili", photoName: "user1")
        let user2 = UserModel(userID: "2", userName: "user2", isAdmin:false, isJury:false ,email:"", sectionID: "2", sectionName: "Bilgisayarla İlgili", photoName: "user2")
        let user3 = UserModel(userID: "3", userName: "user3", isAdmin:false, isJury:false ,email:"", sectionID: "3", sectionName: "Çizimle İlgili", photoName: "user1")
        let user4 = UserModel(userID: "4", userName: "user4", isAdmin:false, isJury:false ,email:"", sectionID: "4", sectionName: "Uzayla İlgili", photoName: "user2")
        let user5 = UserModel(userID: "5", userName: "user5", isAdmin:false, isJury:false ,email:"", sectionID: "5", sectionName: "Camla İlgili", photoName: "user1")
        let user6 = UserModel(userID: "6", userName: "user6", isAdmin:false, isJury:false ,email:"", sectionID: "1", sectionName: "Yemekle İlgili", photoName: "user2")
        
        self.userArray.append(user1)
        self.userArray.append(user2)
        self.userArray.append(user3)
        self.userArray.append(user4)
        self.userArray.append(user5)
        self.userArray.append(user6)

        _ = userArray.filter { section in
            if section.sectionID == "1" {
                self.section1Array.append(section)
            }
            return section.sectionID == "1"
        }
        
        _ = userArray.filter { section in
            if section.sectionID == "2" {
                self.section2Array.append(section)
            }
            return section.sectionID == "2"
        }
        
        _ = userArray.filter { section in
            if section.sectionID == "3" {
                self.section3Array.append(section)
            }
            return section.sectionID == "3"
        }*/
        addAllUSersToArray()
    }
    
    
    func addAllUSersToArray(){
        AuthService.instance.getAllUsers {  (documents, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else if let documents = documents {
                for document in documents {
                    guard let userID = document.data()["user_id"] as? String,
                          let userName = document.data()["display_name"] as? String,
                          let isAdmin = document.data()["is_admin"] as? Bool,
                          let isJury = document.data()["is_jury"] as? Bool,
                          let juryExpert = document.data()["jury_expert"] as? String
                    else {
                                    // Eğer herhangi bir alan eksikse, bu dökümanı atla
                                    print("Error: Missing field in document \(document.documentID)")
                                    continue
                                }
                    let user = UserModel(userID: userID, userName: userName, isAdmin: isAdmin, isJury: isJury, juryExpert: juryExpert)
                    
                    self.userArray.append(user)
                }
            }
        }
    }
}
