//
//  ApplicantsModel.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 15.03.2024.
//

import Foundation
import SwiftUI

struct ApplicantsModel: Identifiable, Hashable{
//    var id: ObjectIdentifier

    var id = UUID()
    var applicantID: String
    var userID: String
    var sectionID: String
//    var photoName: String
    var link: String
    var certificateID: String
   
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
    
