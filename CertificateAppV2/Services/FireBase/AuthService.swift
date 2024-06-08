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
    var onboardingView: OnboardingView!
    
    //MARK: PROPERTIES
    
    static let instance = AuthService()
    
    //Database'de users adlı collection oluşturduk/yazdık
    private var REF_USERS = DB_BASE.collection("users")
    
    //MARK: AUTH USER FUNCTIONS
    
    func logInWithMail(email: String,password: String, handler: @escaping (_ providerID: String?, _ isError: Bool, _ isNewUser : Bool?, _ userID: String?) ->()){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil{
                print("Error loggin in to Firebase with mail")
                handler (nil,true,nil,nil)
                return
            }
            guard let providerID = authResult?.user.uid else{
                print("Error getting provider ID")
                handler(nil,true,nil,nil)
                return
            }
            print("User loggedWithMail USer providerID: \(providerID)")
            
            self.chechIfUserExistsInDatabase(providerID: providerID){ (returnedUserID) in
                
                if let userID = returnedUserID{
                    //user exist
                    handler(providerID,false,false,userID)
                } else {
                    //user does NOT exist
                    handler(providerID,false,true,nil)
                }
                
            }
            //handler(providerID,false)
        }
    }
    
    func logInUserToFirebase(credential: AuthCredential, handler: @escaping (_ providerID: String?, _ isError: Bool) ->()) {
        
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
        print("User id in logInUserToApp : \(userID)")
        
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
        
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            let newProviderID = authResult?.user.uid
            
            print("Oluşturulan user \(newProviderID ?? "unkownID")")
            
            let userData: [String: Any] = [
                DatabaseUserField.displayName: name,
                DatabaseUserField.email: email,
                DatabaseUserField.password: password,
                DatabaseUserField.providerID: newProviderID ?? "",
                DatabaseUserField.provider: provider,
                DatabaseUserField.userID: userID,
                DatabaseUserField.isAdmin: false,
                DatabaseUserField.isJury:false,
                DatabaseUserField.bio:"",
                DatabaseUserField.juryExpert:"",
                DatabaseUserField.certificates:[],
                DatabaseUserField.applicants:[],
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
        
        //upload porfile data to firebase
       
    }
    
    private func chechIfUserExistsInDatabase(providerID: String, handler: @escaping (_ existingUserID:String?) -> ()){
        
        REF_USERS.whereField(DatabaseUserField.providerID, isEqualTo: providerID).getDocuments(){ (querySnaphot, error) in
        
            if let snaphot = querySnaphot, snaphot.count > 0 , let document = snaphot.documents.first{
                //Success
                let existinfUserID = document.documentID
                handler(existinfUserID)
                return
            } else {
                //Error
                handler(nil)
                return
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
    
    func getUserIsJury(forUserID userID:String, handler: @escaping (_ isJury: Bool?)->()){
        REF_USERS.document(userID).getDocument { (documentSnapshot,error) in
            if let document = documentSnapshot,
               
                let isJury = document.get(DatabaseUserField.isJury) as? Bool{
                print("Success geting user info")
                handler(isJury)
                return
            } else {
                print("Error geting user info")
                handler(nil)
                return
            }
        }
    }
    
    func getUserStateInfo(forUserID userID:String, handler: @escaping (_ isAdmin: Bool?)->()){
            
            REF_USERS.document(userID).getDocument { (documentSnapshot,error) in
                if let document = documentSnapshot,
                   
                    let isAdmin = document.get(DatabaseUserField.isAdmin) as? Bool{
                    print("Success geting user is admin")
                    print("sonucu : \(isAdmin)")
                    handler(isAdmin)
                    return
                } else {
                    print("Error geting user info")
                    handler(nil)
                    return
                }
            }
        }
    
    func addCertificateToUser(forUserID userID: String, forCertificateID certificateID: String){
        let userDocument = REF_USERS.document(userID)
        userDocument.updateData([
            DatabaseUserField.certificates: FieldValue.arrayUnion([certificateID])
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func getAllUsers(completion: @escaping ([QueryDocumentSnapshot]?, Error?) -> Void) {
        REF_USERS.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                completion(querySnapshot?.documents, nil)
            }
        }
    }
    
    func addApplicantToJury(forUserID userID: String, forApplicantID applicantID: String){
        let userDocument = REF_USERS.document(userID)
        userDocument.updateData([
            DatabaseUserField.applicants: FieldValue.arrayUnion([applicantID])
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Applicant successfully updated")
            }
        }
    }
    
    func getJuryApplicants(forUserID userID: String, handler: @escaping (_ applicants : [String]?) ->()){
        REF_USERS.document(userID).getDocument{ (documentSnapshot,error)in
            if let document = documentSnapshot,
                let applicants = document.get(DatabaseUserField.applicants) as? [String]{
                print("Success getting jury applicants")
                handler(applicants)
                return
            } else {
                print("Error getting jury applicants")
                handler(nil)
                return
            }
            
        }
    }
    func removeRequestFromJury(forUserID userID: String, forApplicantID applicantID: String){
            let userDocument = REF_USERS.document(userID)
            userDocument.updateData([
                DatabaseUserField.applicants: FieldValue.arrayRemove([applicantID])
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Applicant successfully removed")
                }
            }
        }
}
