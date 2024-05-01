//
//  Enums & Structs.swift
//  CertificateAppV2
//
//  Created by Taha  Adıgüzel on 29.04.2024.
//

import Foundation

struct DatabaseUserField{
    
    //Fileds within th euser document in database/ sürekli elle yazmak yerine burada ortak bir değişkene atıyıp buradan çağıracağız
    
    static let displayName = "display_name"
    static let email = "email"
    static let providerID = "provider_id"
    static let provider = "provider"
    static let userID = "user_id"
    static let bio = "bio"
    static let dateCreated = "date_created"
    
}

struct CurrentUserDefaults{
    static let displayName = "display_name"
    static let bio = "bio"
    static let userID = "user_id"
}