//
//  ApplicantsArrayObject.swift
//  userAppV2
//
//  Created by Eda Eren on 5.06.2024.
//

import Foundation
class ApplicantsArrayObject: ObservableObject{
    static let shared = ApplicantsArrayObject()
//    @Published var applicantsArray = [ApplicantsModel]()
    @Published var applicantsArray: [ApplicantsModel] = []
    
    @Published var requestArray: [ApplicantsModel] = []
    
//    @Published var section1Array = [ApplicantsModel]()
    @Published var section1Array : [ApplicantsModel] = []
    @Published var section2Array : [ApplicantsModel] = []
    @Published var section3Array : [ApplicantsModel] = []

    
    private init(){
//        print("fetch from database here")
        //photoName de eklenecek su an currentUserInfo'sunda sadeve bio vs oldugu icin foto olmadigi icin ekleyemedim
//       let user1 = ApplicantsModel(userID: "1",  sectionID: "1", link: "a", certificateID: "1")
//        let user2 = ApplicantsModel(userID: "2",  sectionID: "2",   link: "", certificateID: "")
//        let user3 = ApplicantsModel(userID: "3",  sectionID: "3",  link: "", certificateID: "")
//        let user4 = ApplicantsModel(userID: "4", sectionID: "4",   link: "", certificateID: "")
//        let user5 = ApplicantsModel(userID: "5",  sectionID: "5",  link: "", certificateID: "")
//        let user6 = ApplicantsModel(userID: "6",  sectionID: "1",  link: "b", certificateID: "1")
        
//        self.applicantsArray.append(user1)
       /* self.applicantsArray.append(user2)
        self.applicantsArray.append(user3)
        self.applicantsArray.append(user4)
        self.applicantsArray.append(user5)*/
//        self.applicantsArray.append(user6)

//        addApplicant2()
        /*
        _ = applicantsArray.filter { section in
            if section.sectionID == "1" {
                self.section1Array.append(section)
            }
            return section.sectionID == "1"
        }
        
        _ = applicantsArray.filter { section in
            if section.sectionID == "2" {
                self.section2Array.append(section)
            }
            return section.sectionID == "2"
        }*/
        getApplicants()
        updateSections()
        /*
        _ = applicantsArray.filter { section in
            if section.sectionID == "3" {
                self.section3Array.append(section)
            }
            return section.sectionID == "3"
        }*/
        
        /*
        init(applicants : ApplicantsModel){
            self.applicantsArray.append(applicants)
        }*/
    }
    
    
    /*
    func addApplicant2() {
//        applicantsArray.append(applicant)
        _ = applicantsArray.filter { section in
            if section.sectionID == "1" {
                self.section1Array.append(section)
            }
            return section.sectionID == "1"
        }
    }*/
    
    // Function to add an applicant
        func addApplicant(_ applicant: ApplicantsModel) {
            applicantsArray.append(applicant)
            updateSections()
        }
   
    
    private func updateSections() {
            section1Array = applicantsArray.filter { $0.sectionID == "1" }
            section2Array = applicantsArray.filter { $0.sectionID == "2" }
            section3Array = applicantsArray.filter { $0.sectionID == "3" }
        }
    
    /*
    func removeApplicant(_ applicant: ApplicantsModel) {
            if let index = applicantsArray.firstIndex(where: { $0.userID == applicant.userID && $0.sectionID == sectionID }) {
                applicantsArray.remove(at: index)
                updateSections()
            }
        }*/
    /*
    func removeApplicant(userID: String, sectionID: String) {
            if let index = applicantsArray.firstIndex(where: { $0.userID == userID && $0.sectionID == sectionID }) {
                applicantsArray.remove(at: index)
                updateSections()
            }
        }*/
    func removeApplicant(userID: String, certificateID: String) {
            if let index = applicantsArray.firstIndex(where: { $0.userID == userID && $0.certificateID == certificateID }) {
                applicantsArray.remove(at: index)
                updateSections()
            }
        }

    func getApplicants(){
        ApplicantService.instance.getAllAplicants{ (documents,error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else if let documents = documents {
                for document in documents {
                    //print("Document ID: \(document.documentID)")
                    guard let certificateID = document.data()["certificate_id"] as? String,
                          let sectionID = document.data()["section_id"] as? String,
                          let userID = document.data()["user_id"] as? String,
                          let link = document.data()["link"] as? String
                    else {
                                    // Eğer herhangi bir alan eksikse, bu dökümanı atla
                                    print("Error: Missing field in document \(document.documentID)")
                                    continue
                                }
                    let user = ApplicantsModel(applicantID: document.documentID ,userID: userID,  sectionID: sectionID, link: link, certificateID: certificateID)
                    self.addApplicant(user)
                    print("gelen applicants'lar : \(document)")

                }
            }

        }
    }
    
    func clearList(){
        applicantsArray.removeAll()
    }
    func clearRequestList(){
        requestArray.removeAll()
    }
    /*
    //requestleri databaseteen silmek icin
    func deleteRequest(applicantID:String){
        AuthService.instance.removeRequestFromJury(forUserID: <#String#>, forApplicantID: applicantID)
    }*/
    //requestleri arrayden silmek icin
    /*
    func deleteRequest(_ applicant: ApplicantsModel) {
        AuthService.instance.removeRequestFromJury(forUserID: applicant.userID, forApplicantID: applicant.certificateID)
   }*/
    func removeRequest(userID: String, applicantID: String) {
            if let index = requestArray.firstIndex(where: { $0.userID == userID && $0.applicantID == applicantID }) {
                requestArray.remove(at: index)
                clearRequestList()
                getApplicants()
            }
        }
    
    func updateSectionFromOutside(){
        clearList()
        getApplicants()
        updateSections()
    }
    func deleteApplicant(applicantID:String){
            ApplicantService.instance.deleteApplicant(forApplicantID: applicantID)
        }
    /*
    func getRequest(forUserID userID:String?){
        if userID != ""{
            if let user = userID {
                AuthService.instance.getJuryApplicants(forUserID: userID!){ (returnedRequests) in
                    if let request = returnedRequests {
                            // Sertifika listesini ekrana yazdır
                        for item in request{
                            print("gelen applicant id: \(item)")
                            self.getRequsetInfo(forRequsetID: item)
                        }
                        } else {
                            print("Sertifikalar alınamadı.")
                        }
                }
            }
        } else {
            print("User not found")
        }
    }
    
    func getRequsetInfo(forRequsetID requestID: String){
        ApplicantService.instance.getApplicantInfo(forApplicantID: requestID){(certificateID,userID,applicantLink,sectionID) in
            if let certificateId = certificateID{
                if let userId = userID{
                    if let link = applicantLink{
                        if let sectionId = sectionID{
                            let applicant = ApplicantsModel(applicantID: requestID, userID: userId, sectionID: sectionId, link:link, certificateID: certificateId )
                            self.requestArray.append(applicant)
                            print("Eklenen applicant : \(applicant)")
                        }
                    }
                }
            }
        }
        
    }*/
    func getRequest(forUserID userID: String?, completion: @escaping () -> Void) {
            if let user = userID, !user.isEmpty {
                AuthService.instance.getJuryApplicants(forUserID: user) { [weak self] (returnedRequests) in
                    guard let self = self else { return }
                    if let requests = returnedRequests {
                        let group = DispatchGroup()
                        for item in requests {
                            group.enter()
                            self.getRequsetInfo(forRequsetID: item) {
                                group.leave()
                            }
                        }
                        group.notify(queue: .main) {
                            completion()
                        }
                    } else {
                        print("Sertifikalar alınamadı.")
                        completion()
                    }
                }
            } else {
                print("User not found")
                completion()
            }
        }
        
        func getRequsetInfo(forRequsetID requestID: String, completion: @escaping () -> Void) {
            ApplicantService.instance.getApplicantInfo(forApplicantID: requestID) { [weak self] (certificateID, userID, applicantLink, sectionID) in
                guard let self = self else { return }
                if let certificateId = certificateID, let userId = userID, let link = applicantLink, let sectionId = sectionID {
                    let applicant = ApplicantsModel(applicantID: requestID, userID: userId, sectionID: sectionId, link: link, certificateID: certificateId)
                    DispatchQueue.main.async {
                        self.requestArray.append(applicant)
                        print("Eklenen applicant: \(applicant)")
                        completion()
                    }
                } else {
                    completion()
                }
            }
        }
    func addRequest(_ applicant: ApplicantsModel) {
            requestArray.append(applicant)
        }
    /*
    private func updateSections() {
           /* section1Array = applicantsArray.filter { $0.sectionID == "1" }
            section2Array = applicantsArray.filter { $0.sectionID == "2" }*/
        _ = applicantsArray.filter { section in
            if section.sectionID == "1" {
                self.section1Array.append(section)
            }
            return section.sectionID == "1"
        }
        _ = applicantsArray.filter { section in
            if section.sectionID == "2" {
                self.section2Array.append(section)
            }
            return section.sectionID == "2"
        }
        _ = applicantsArray.filter { section in
            if section.sectionID == "3" {
                self.section3Array.append(section)
            }
            return section.sectionID == "3"
        }
        }*/
     /*
       func addApplicant(_ applicant: ApplicantsModel) {
           applicantsArray.append(applicant)
           _ = applicantsArray.filter { section in
               if section.sectionID == "1" {
                   self.section1Array.append(section)
               }
               return section.sectionID == "1"
           }
       }*/
    /*
    init(applicant : ApplicantsModel){
        self.applicantsArray.append(applicant)
    }*/
       
}
