//
//  SingInWithGoogle.swift
//  CertificateAppV2
//
//  Created by Taha  Adıgüzel on 23.04.2024.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth
class SingInWithGoogle: NSObject, GIDSignInDelegate {
    
    static let instance = SignInWithGoogle()
    var onboardingView: OnboardingView!
    
    func startSıgnInWithGoogleFlow(view: OnboardingView){
        self.onboardingView = view
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        GIDSignIn.sharedInstance().presentingViewController.modalPresentationStyle = .fullScreen
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!,didSignInFor user: GIDGoogleUser!, withError error: Error?){
        if let error = error{
            print("ERROR SIGNING IN TO GOOGLE")
            self.onboardingView.showError.toggle()
            return
        }
        
        let fullName : String = user.profile.name
        let email : String = user.profile.email
        
        let idToken: String = user.authentication.idToken
        let accessToken: String = user.authentication.accessToken
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        print("SIGN IN TO FIREBASE NOW. WITH NAME : \(fullName) and EMAIL: \(email)")
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!){
        print("USER DISCONNECTED FROM GOOGLE")
        self.onboardingView.showError.toggle()
    }
}
