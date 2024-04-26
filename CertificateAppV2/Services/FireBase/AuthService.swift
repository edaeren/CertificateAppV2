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

class AuthService{
    
    //MARK: PROPERTIES
    
    static let instance = AuthService()
    
    //MARK: AUTH USER FUNCTIONS
    
    func logInUserToFirebase(credential: AuthCredential, handler: @escaping (_ provierID: String?, _ isError: Bool) ->()) {
        
        Auth.auth().signIn(with:credential){(result,error) in
            if  error != nil{
                print("Error logging in to FireBase")
                handler(nil,true)
                return
            }
            guard let providerID = result?.user.uid else {
                print("HATA VAR LAN")
                handler(nil,true)
                return
            }
            handler(providerID,false)
        }
       
        
        
        
    }
}
