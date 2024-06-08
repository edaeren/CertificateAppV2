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
    
    func deleteApplicant(applicantID:String){
        ApplicantService.instance.deleteApplicant(forApplicantID: applicantID)
    }
    
    func updateSectionFromOutside(){
        clearList()
        getApplicants()
        updateSections()
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
