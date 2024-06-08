//
//  UserArrayObject.swift
//  userAppV2
//
//  Created by Eda Eren on 5.06.2024.
//

import Foundation
class UserArrayObject: ObservableObject{
    @Published var userArray = [UserModel]()
    @Published var requestArray = [UserModel]()
    @Published var section1Array = [UserModel]()
    
    init(){
        /*
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
                          let juryExpert = document.data()["jury_expert"] as? String,
                          let isAdmin = document.data()["is_admin"] as? Bool,
                          let isJury = document.data()["is_jury"] as? Bool
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
