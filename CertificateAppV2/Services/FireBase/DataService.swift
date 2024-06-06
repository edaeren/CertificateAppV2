//
//  DataService.swift
//  CertificateAppV2
//
//  Created by Taha  Adıgüzel on 4.06.2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class DataService {
    static let instance = DataService()
    
    private var REF_CERTIFICATES = DB_BASE.collection("certificates")
    
    
    // MARK: GET FUNCTIONS
    
    func getCertificateInfo(forCertificateID certifiacteID:String, handler: @escaping (_ name: String?, _ bio: String?)->()){
        REF_CERTIFICATES.document(certifiacteID).getDocument { (documentSnapshot,error) in
            if let document = documentSnapshot,
               
                let description = document.get(DatabaseCertificateField.description) as? String,
               let requirements = document.get(DatabaseCertificateField.requirements) as? String{
                print("Success geting certificate info")
                handler(description,requirements)
                return
            } else {
                print("Error geting certificate info")
                handler(nil,nil)
                return
            }
        }
    }
    
    func getAllCertificates(completion: @escaping ([QueryDocumentSnapshot]?, Error?) -> Void) {
        REF_CERTIFICATES.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                completion(querySnapshot?.documents, nil)
            }
        }
    }

}
