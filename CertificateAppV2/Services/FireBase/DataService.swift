//
//  DataService.swift
//  CertificateAppV2
//
//  Created by Taha  Adıgüzel on 4.06.2024.
//

import Foundation
import FirebaseFirestore

class DataService {
    static let instance = DataService()
    
    private var REF_CERTIFICATES = DB_BASE.collection("certificates")
    private var REF_USERCERTIFICATES = DB_BASE.collection("users")
    
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
    
    func getCertificateInfoForDataArray(forCertificateID certifiacteID:String, handler: @escaping (_ certificateName: String?, _ sectionID: String?, _ sectionName: String?)->()){
        REF_CERTIFICATES.document(certifiacteID).getDocument { (documentSnapshot,error) in
            if let document = documentSnapshot,
                let certificateName = document.get(DatabaseCertificateField.certificateName) as? String,
                let sectionID = document.get(DatabaseCertificateField.sectionID) as? String,
                let sectionName = document.get(DatabaseCertificateField.sectionName) as? String{
                print("Success geting certificate info")
                handler(certificateName,sectionID,sectionName)
                return
            } else {
                print("Error geting certificate info")
                handler(nil,nil,nil)
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
    
    func getUserCertificates(forUserID userID: String, handler: @escaping (_ certificateID: [String]?) ->()){
        REF_USERCERTIFICATES.document(userID).getDocument{ (documentSnapshot,error)in
            if let document = documentSnapshot,
                let certificates = document.get(DatabaseUserField.certificates) as? [String]{
                print("Success getting user certificates")
                handler(certificates)
                return
            } else {
                print("Error getting user certificates")
                handler(nil)
                return
            }
            
        }
    }

}
