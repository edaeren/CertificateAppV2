//
//  UserModel.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 15.03.2024.
//

import Foundation
import SwiftUI

struct UserModel: Identifiable, Hashable{
    var id: ObjectIdentifier
    
    var id2 = UUID()
    var userID: String
    var userName: String
    var adminOrNot: Bool
    var adminKurum: String?
    var email: String?
    var password: String?
   
    
    //userID
    //userName
    //adminOrNot
    //adminKurum
    //email
    //password
}
    
