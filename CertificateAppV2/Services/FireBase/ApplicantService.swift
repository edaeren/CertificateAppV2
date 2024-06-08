//
//  ApplicantService.swift
//  CertificateAppV2
//
//  Created by Taha  Adıgüzel on 8.06.2024.
//

import Foundation
import FirebaseFirestore

class ApplicantService{
    static let instance = ApplicantService()
    
    private var REF_CERTIFICATES = DB_BASE.collection("applicants")
    
    func createApplicant(userID: String, sectionID: String, link: String, certificateID: String){
        
        let document = REF_CERTIFICATES.document()
        
        let applicantData: [String: Any] = [
            ApplicantField.userID : userID,
            ApplicantField.sectionID:sectionID,
            ApplicantField.link:link,
            ApplicantField.certificateID:certificateID,
            DatabaseUserField.dateCreated: FieldValue.serverTimestamp(),
        ]
        
        document.setData(applicantData){ (error) in
            
            if let error = error{
                //Error
                print("Error uploading data to applicant document. \(error)")
            }else{
                //success
                print("Applicant addet successfully")
            }
        }
    }
    
    func getAllAplicants(completion: @escaping ([QueryDocumentSnapshot]?, Error?) -> Void) {
        REF_CERTIFICATES.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                completion(querySnapshot?.documents, nil)
            }
        }
    }
}
