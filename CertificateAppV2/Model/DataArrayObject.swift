//
//  dataArrayObject.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 15.03.2024.
//

import Foundation
class DataArrayObject: ObservableObject{
    
    //blank array of certificatemodel
    @Published var dataArray = [CertificateModel]()
    @Published var section1Array = [CertificateModel]()
    @Published var section2Array = [CertificateModel]()
    @Published var section3Array = [CertificateModel]()
//    @Published var sectionsArray = [CertificateModel]()
    
    init(){
        print("fetch from database here")
        let data1 = CertificateModel(certificateID: "", certificateName: "yemekk", sectionID: "1", sectionName: "Yemekle İlgili",description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce volutpat varius elementum. In volutpat ligula ornare erat lacinia, non finibus odio vestibulum. Donec eu euismod turpis.", requirements: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce volutpat varius elementum. In volutpat ligula ornare erat lacinia, non finibus odio vestibulum. Donec eu euismod turpis.")
        let data2 = CertificateModel(certificateID: "", certificateName: "cizim", sectionID: "2", sectionName: "Çizimle İlgili")
        let data3 = CertificateModel(certificateID: "", certificateName: "bilgisayar", sectionID: "3", sectionName: "Bilgisayarla İlgili")
        let data4 = CertificateModel(certificateID: "", certificateName: "yemekk4", sectionID: "4", sectionName: "Uzayla İlgili")
        let data5 = CertificateModel(certificateID: "", certificateName: "yemekk5", sectionID: "5", sectionName: "Camla İlgili")
        let data6 = CertificateModel(certificateID: "", certificateName: "yemekk6", sectionID: "1", sectionName: "Yemekle İlgili")
        
        self.dataArray.append(data1)
        self.dataArray.append(data2)
        self.dataArray.append(data3)
        self.dataArray.append(data4)
        self.dataArray.append(data5)
        self.dataArray.append(data6)
        
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
        
        _ = dataArray.filter { section in
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
        }
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
    
    
}
