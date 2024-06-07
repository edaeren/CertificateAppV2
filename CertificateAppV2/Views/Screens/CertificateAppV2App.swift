//
//  CertificateAppV2App.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 13.03.2024.
//

import SwiftUI
import Firebase
@main
struct CertificateAppV2App: App {
    
    init(){
        FirebaseApp.configure()
    }
    @StateObject private var applicantsArray = ApplicantsArrayObject.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(applicantsArray)
        }
    }
}
