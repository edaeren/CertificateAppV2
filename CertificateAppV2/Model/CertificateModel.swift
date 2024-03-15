//
//  CertificateModel.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 15.03.2024.
//

import Foundation
import SwiftUI

struct CertificateModel: Identifiable, Hashable{
    
    var id = UUID()
    var certificateID: String
    var certificateName: String
    var sectionID: String
    var sectionName: String

    var description: String?
    var requirements: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
   
    
    
    //certificateID
    //sectionID
    //sectionName
    //certificateName
    //publisherID
    //publisherName
    //description
    //requirements
    //video-optional
    //ratings-optinal
    //userID
    //userName
    
    
}
