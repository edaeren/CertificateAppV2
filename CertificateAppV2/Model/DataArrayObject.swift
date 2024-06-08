//
//  dataArrayObject.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 15.03.2024.
//

import Foundation
import UIKit

class DataArrayObject: ObservableObject {
    
    //blank array of certificatemodel
    @Published var dataArray = [CertificateModel]()
    @Published var dataArrayUser = [CertificateModel]()
    @Published var section1Array = [CertificateModel]()
    @Published var section2Array = [CertificateModel]()
    @Published var section3Array = [CertificateModel]()
    @Published var sectionArrayUser = [CertificateModel]()
    
//    @Published var sectionsArray = [CertificateModel]()
    
    init(forUserID userID:String){
        
        DataService.instance.getAllCertificates { (documents, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else if let documents = documents {
                for document in documents {
                    //print("Document ID: \(document.documentID)")
                    guard let certificateName = document.data()["certificateName"] as? String,
                                      let sectionID = document.data()["sectionID"] as? String,
                                      let sectionName = document.data()["sectionName"] as? String
                    
                    else {
                                    // Eğer herhangi bir alan eksikse, bu dökümanı atla
                                    print("Error: Missing field in document \(document.documentID)")
                                    continue
                                }
                    var certificateImage: UIImage = UIImage(named: "logo.loading")!
                    ImageManager.instance.downloadCertificateImage(certificateID: document.documentID) { (returnedImage) in
                        if let image = returnedImage {
                            certificateImage = image
                        }
                    }
                    let data = CertificateModel(certificateID: document.documentID, certificateName: certificateName, sectionID: sectionID, sectionName: sectionName, photo: certificateImage)
                    
                    self.dataArray.append(data)
                    
                }
                print("Data Array Function: \(self.dataArray)")
            }
            
            self.getUserSertificates(forUserID: userID)
        }
        
        
       /* DataService.instance.getAllCertificates2 { (certificates, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else if let certificates = certificates {
                self.dataArray = certificates
                // dataArray güncellendi, şimdi gerekli diğer işlemleri yapabiliriz.
                print("Data Array Function: \(self.dataArray)")
            }
        }*/
    /*
        if(data1.sectionID=="1"){
            self.section1Array.append(data1)
        }
        if(data6.sectionID=="1"){
            self.section1Array.append(data6)
        }*/
        
        /*
        let sectionedData = dataArray.filter{ section in
            if section.sectionID == "1"{
                self.section1Array.append(section)
                return true
            }
            else{
                return false
            }
        }*/
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // section1Array'yi doldur
            _ = self.dataArray.filter { section in
                if section.sectionID == "1" {
                    self.section1Array.append(section)
                }
                return section.sectionID == "1"
            }

            // section2Array'yi doldur
            _ = self.dataArray.filter { section in
                if section.sectionID == "2" {
                    self.section2Array.append(section)
                }
                return section.sectionID == "2"
            }

            // section3Array'yi doldur
            _ = self.dataArray.filter { section in
                if section.sectionID == "3" {
                    self.section3Array.append(section)
                }
                return section.sectionID == "3"
            }
            
            _ = self.dataArrayUser.filter { section in
                
                self.sectionArrayUser.append(section)
               
                return section.sectionID == "4"
            }
           
            
        }

        
        /*_ = dataArray.filter { section in
            if section.sectionID == "1" {
                self.section1Array.append(section)
            }
            return section.sectionID == "1"
        }
        _ = dataArray.filter { section in
            if section.sectionID == "2" {
                self.section2Array.append(section)
            }
            return section.sectionID == "2"
        }
        _ = dataArray.filter { section in
            if section.sectionID == "3" {
                self.section3Array.append(section)
            }
            return section.sectionID == "3"
        }*/
        
        /*
        let sectioned2Data = dataArray.filter { section in
            if section.sectionID == "2" {
                self.section2Array.append(section)
            }
            return section.sectionID == "2"
        }*/
    }
    //USED FOR SINGLE CERTIFICATE SELECTION--deneme
    init(certificate: CertificateModel){
        self.dataArray.append(certificate)
    }
    
    
    func getUserSertificates(forUserID userID:String?){
        if userID != ""{
            if let user = userID {
                DataService.instance.getUserCertificates(forUserID: userID!){ (certificates) in
                    if let certificates = certificates {
                            // Sertifika listesini ekrana yazdır
                        for item in certificates{
                            self.getCertificateInformations(forCertificateID: item)
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
    
    func getCertificateInformations(forCertificateID certificateID:String){
        DataService.instance.getCertificateInfoForDataArray(forCertificateID: certificateID){(certificateName,sectionID,sectionName) in
            if let name = certificateName{
                if let id = sectionID{
                    if let sName = sectionName{
                        print("ID: \(String(describing: id))")
                        print("Name: \(String(describing: name))")
                        print("sName: \(String(describing: sName))")
                        
                        var certificateImage: UIImage = UIImage(named: "logo.loading")!
                        ImageManager.instance.downloadCertificateImage(certificateID: certificateID) { (returnedImage) in
                            if let image = returnedImage {
                                certificateImage = image
                            }
                        }
                        
                        let data = CertificateModel(certificateID: certificateID, certificateName: name, sectionID: id, sectionName: sName, photo: certificateImage)
                        self.dataArrayUser.append(data)
                    }
                }
            }
        }
    }
    
}
