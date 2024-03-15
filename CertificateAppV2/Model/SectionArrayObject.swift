//
//  SectionArrayObject.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 15.03.2024.
//

import Foundation
class SectionArrayObject: ObservableObject{
    
    //blank array of certificatemodel
    @Published var SectionArray = [CertificateModel]()
    
    init(){
        print("fetch from database here")
        let section1 = CertificateModel(certificateID: "", certificateName: "yemekk", sectionID: "", sectionName: "Yemekle İlgili")
        let section2 = CertificateModel(certificateID: "", certificateName: "yemekk2", sectionID: "", sectionName: "Çizimle İlgili")
        let section3 = CertificateModel(certificateID: "", certificateName: "yemekk3", sectionID: "", sectionName: "Bilgisayarla İlgili")
        let section4 = CertificateModel(certificateID: "", certificateName: "yemekk4", sectionID: "", sectionName: "Uzayla İlgili")
        
        self.SectionArray.append(section1)
        self.SectionArray.append(section2)
        self.SectionArray.append(section3)
        self.SectionArray.append(section4)
    }
    
    
}
