//
//  AuthService.swift
//  CertificateAppV2
//
//  Created by Taha  Adıgüzel on 23.04.2024.
//

// Used to Authenticate users in FireBase
// Used yo handle user accounts in FireBase

import Foundation
import FirebaseAuth
import FirebaseFirestore // Database
import UIKit

let DB_BASE  = Firestore.firestore()

class AuthService{
    
    //MARK: PROPERTIES
    
    static let instance = AuthService()
    
    //Database'de users adlı collection oluşturduk/yazdık
    private var REF_USERS = DB_BASE.collection("users")
    
    //MARK: AUTH USER FUNCTIONS
    
    func logInUserToFirebase(credential: AuthCredential, handler: @escaping (_ provierID: String?, _ isError: Bool) ->()) {
        
        Auth.auth().signIn(with:credential) { (result, error) in
            if  error != nil{
                print("Error logging in to FireBase")
                handler(nil,true)
                return
            }
            guard let providerID = result?.user.uid else {
                print("Error getting provider ID")
                handler(nil,true)
                return
            }
            handler(providerID,false)
        }
    }
    
    //
    func logInUserToApp(userID: String, handler: @escaping (_ success: Bool)-> ()){
        //Get the users info
        getUserInfo(forUserID: userID){(returnedName,returnedBio) in
            if let name = returnedName, let bio = returnedBio {
                //Success
                print("Success getting user info while logging in")
                handler(true)
                
                //set the users info to our app
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    //Kullanıcının bilgileri kaydediliyor ki uygulama açıldığında otomatik bilgiler gelsin tarzı bir şey?
                    UserDefaults.standard.set(userID, forKey: CurrentUserDefaults.userID)
                    UserDefaults.standard.set(bio, forKey: CurrentUserDefaults.bio)
                    UserDefaults.standard.set(name, forKey: CurrentUserDefaults.displayName)
                }
              
                
            } else {
                //Error
                print("Error getting user info while logging in")
                handler(false)
            }
        }
    }
    
    func logOutUser(handler: @escaping(_ success: Bool) -> ()){
        
        do{
            try Auth.auth().signOut()
        }catch{
            print("Error \(error)")
            handler(false)
            return
        }
        handler(true)
    }
    
    //database'de yeni kullanıcı oluşturmak
    func createNewUserInDatabase(name: String, email: String, password: String ,providerID: String, provider: String, profileImage: UIImage,handler: @escaping(_ userID: String?)->()){
        
        //set up a user document with user collection
        
        let document = REF_USERS.document()
        let userID = document.documentID
        
        //upload profile image to storage
        ImageManager.instance.uploadProfileImage(userID: userID, image: profileImage)
        
        //upload porfile data to firebase
        let userData: [String: Any] = [
            DatabaseUserField.displayName: name,
            DatabaseUserField.email: email,
            DatabaseUserField.password: password,
            DatabaseUserField.providerID: providerID,
            DatabaseUserField.provider: provider,
            DatabaseUserField.userID: userID,
            DatabaseUserField.bio:"",
            DatabaseUserField.dateCreated: FieldValue.serverTimestamp(),
        ]
        
        document.setData(userData){ (error) in
            
            if let error = error{
                //Error
                print("Error uploading data to user document. \(error)")
                handler(nil)
            }else{
                //success
                handler(userID)
            }
        }
    }
    
    //MARK:  GET USER FUNCTIONS
    func getUserInfo(forUserID userID:String, handler: @escaping (_ name: String?, _ bio: String?)->()){
        
        REF_USERS.document(userID).getDocument { (documentSnapshot,error) in
            if let document = documentSnapshot,
               
                let name = document.get(DatabaseUserField.displayName) as? String,
                let bio = document.get(DatabaseUserField.bio) as? String{
                print("Success geting user info")
                handler(name,bio)
                return
            } else {
                print("Error geting user info")
                handler(nil,nil)
                return
            }
        }
    }
}
