//
//  UserModel.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 15.03.2024.
//

import Foundation
import SwiftUI

struct UserModel: Identifiable, Hashable{
//    var id: ObjectIdentifier

    var id = UUID()
    var userID: String
    var userName: String
    var adminOrNot: Bool
    var adminKurum: String?
    var email: String?
    var password: String?
    var sectionID: String?
    var sectionName: String?
    var photoName: String
   
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    //userID
    //userName
    //adminOrNot
    //adminKurum
    //email
    //password
}
    
