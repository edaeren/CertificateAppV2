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
    static let password = "password"
    static let providerID = "provider_id"
    static let provider = "provider"
    static let userID = "user_id"
    static let bio = "bio"
    static let dateCreated = "date_created"
    static let isAdmin = "is_admin"
    static let isJury = "is_jury"
    static let juryExpert = "jury_expert"
    static let certificates = "certificates"
    
}

struct CurrentUserDefaults{
    static let displayName = "display_name"
    static let bio = "bio"
    static let userID = "user_id"
}

struct DatabaseCertificateField{
    static let certificateID = "certificate_id"
    static let certificateName = "certificateName"
    static let description = "description"
    static let requirements = "requirements"
    static let sectionID = "sectionID"
    static let sectionName = "sectionName"
}

struct ApplicantField{
    static let applicantID = "applicant_id"
    static let userID = "user_id"
    static let sectionID = "section_id"
    static let link = "link"
    static let certificateID = "certificate_id"
}
