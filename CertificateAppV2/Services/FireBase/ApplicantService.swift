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
    
    private var REF_APPLICANTS = DB_BASE.collection("applicants")
    
    func createApplicant(userID: String, sectionID: String, link: String, certificateID: String){
        
        let document = REF_APPLICANTS.document()
        
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
        REF_APPLICANTS.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                completion(querySnapshot?.documents, nil)
            }
        }
    }
    
    func deleteApplicant(forApplicantID applicantID: String){
        REF_APPLICANTS.document(applicantID).delete()
    }
    
    func getApplicantInfo(forApplicantID applicantID: String, handler: @escaping (_ certificateID: String?, _ userID: String?, _ applicantLink: String?, _ sectionID : String?)->()){
        REF_APPLICANTS.document(applicantID).getDocument { (documentSnapshot,error) in
            if let document = documentSnapshot,
                let certificateID = document.get(ApplicantField.certificateID) as? String,
                let userID = document.get(ApplicantField.userID) as? String,
                let applicantLink = document.get(ApplicantField.link) as? String,
                let sectionID = document.get(ApplicantField.sectionID) as? String
                {
                print("Success geting request info")
                handler(certificateID,userID,applicantLink,sectionID)
                return
            } else {
                print("Error geting request info")
                handler(nil,nil,nil,nil)
                return
            }
        }
    }
}
