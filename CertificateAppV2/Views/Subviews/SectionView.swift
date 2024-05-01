//
//  SectionView.swift/Users/edaeren/bitirme/CertificateAppV4/CertificateAppV2/Views/Screens/CertificateView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 14.03.2024.
//

import SwiftUI

struct SectionView: View {
    @ObservedObject var section1 : DataArrayObject
    @ObservedObject var section2 : DataArrayObject
    @ObservedObject var section3 : DataArrayObject

    var body: some View {
        
        // MARK: IMAGE/SERTİFİKALAR
        
        ScrollView(.vertical) {
            
            VStack{
                // MARK: YEMEKLE ILGILI SERTIFIKALAR
                HStack {
                 Text("Yemekle ilgili Sertifikalar")
                      .font(.title3)
                      .fontWeight(.heavy)
                       .foregroundColor(.primary)
                       .padding(.leading,5)
//                       .fontDesign(.)
                    Spacer()
                Image(systemName: "ellipsis") //sagdaki uc nokta
                        .font(.headline) //belki buraya tiklayarak geri kalan sertifikalara bakilabilir. tumunu gor gibi
                    }
                    .padding(.all, 6)
                // MARK: YEMEK SERTIFIKALARI SCROLLVIEWI
                ScrollView(.horizontal){
                    HStack{
        //                ForEach(sections)  sectionlari icinde tutan arrayi gezerek tek bir baslik saglama
                        ForEach(section1.section1Array, id : \.self){data in
                            NavigationLink(
                                destination: CertificateView(certificates: data),
                                label: {
                                 MiniCertificateView(data : data)
//                                 MiniCertificateView(data : data, showHeader: true)
                                })
                        }.fixedSize()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        /*
                         ForEach(datas.dataArray, id : \.self){data in
                         MiniCertificateView(data : data)
                         }*/
                    }
                }
                // MARK: CİZİM SERTİFİKALAR
                VStack{
                    HStack {
                     Text("Çizimle ilgili Sertifikalar")
                          .font(.title3)
                          .fontWeight(.heavy)
                           .foregroundColor(.primary)
                           .padding(.leading,5)
    //                       .fontDesign(.)
                        Spacer()
                    Image(systemName: "ellipsis") //sagdaki uc nokta
                            .font(.headline) //belki buraya tiklayarak geri kalan sertifikalara bakilabilir. tumunu gor gibi
                        }
                        .padding(.all, 6)
                }
                ScrollView(.horizontal){
                    HStack{
                        ForEach(section2.section2Array, id : \.self){data in
                            NavigationLink(
                                destination: CertificateView(certificates: data),
                                label: {
                                 MiniCertificateView(data : data)
//                                 MiniCertificateView(data : data, showHeader: true)
                                })
                        }.fixedSize()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                // MARK: BILGISAYAR SERTİFİKALAR
                VStack{
                    HStack {
                     Text("Bilgisayarla ilgili Sertifikalar")
                          .font(.title3)
                          .fontWeight(.heavy)
                           .foregroundColor(.primary)
                           .padding(.leading,5)
    //                       .fontDesign(.)
                        Spacer()
                    Image(systemName: "ellipsis") //sagdaki uc nokta
                            .font(.headline) //belki buraya tiklayarak geri kalan sertifikalara bakilabilir. tumunu gor gibi
                        }
                        .padding(.all, 6)
                }
                ScrollView(.horizontal){
                    HStack{
                        ForEach(section3.section3Array, id : \.self){data in
                            NavigationLink(
                                destination: CertificateView(certificates: data),
                                label: {
                                 MiniCertificateView(data : data)
//                                 MiniCertificateView(data : data, showHeader: true)
                                })
                        }.fixedSize()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                
                
                
            }//ven ust stack?
            
        }//en ust scrollviewin
        
        //MARK: FOOTER
        //                .padding(.all,6)
        //        })//vstackin
        
    }
}



struct SectionView_Previews: PreviewProvider{
    
    static var previews: some View{
//        SectionView(section: <#T##CertificateModel#>, datas: DataArrayObject())
      //    SectionView(datas: DataArrayObject(), section1: DataArrayObject())
        SectionView(section1: DataArrayObject(), section2: DataArrayObject(), section3: DataArrayObject())
            .previewLayout(.sizeThatFits)
    }
}
