//
//  SectionView
//  CertificateAppV2
//
//  Created by Eda Eren on 14.03.2024.
//

import SwiftUI

struct SectionView: View {
    @ObservedObject var section1 : DataArrayObject
    @ObservedObject var section2 : DataArrayObject
    @ObservedObject var section3 : DataArrayObject
    @ObservedObject var sectionUser: DataArrayObject
    @State var showAll: Bool = false
    @State var selectedSectionID: String? = nil

    var body: some View {
        
        // MARK: IMAGE/SERTİFİKALAR
        
        ScrollView(.vertical) {
            
            VStack{
                // MARK: YEMEKLE ILGILI SERTIFIKALAR
                HStack {
                 Text("Food Related Certificates")
                      .font(.title3)
                      .fontWeight(.heavy)
                       .foregroundColor(.primary)
                       .padding(.leading,5)
//                       .fontDesign(.)
                    Spacer()
                    Button(action: {
                        //bu sectiondaki tum sertifikalari listede
                        selectedSectionID = "1"
                        showAll.toggle()
//
                    }, label: {
                        Image(systemName: "ellipsis")
                            .font(.title3)
                            .fontWeight(.heavy)

                    })
                    
                    .foregroundColor(.primary)
                    .padding(.leading,5)
                    .padding(.trailing,20)
                    }
                    .padding(.all, 6)
                    .fullScreenCover(isPresented: $showAll, content: {
                        if let sectionID = selectedSectionID {
                                               ShowAllCertificatesView(sectionID: sectionID, dataArrayObject: getSectionDataArrayObject(for: sectionID))
                                           }
                    })
                    
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
                     Text("Drawing Related Certificates")
                          .font(.title3)
                          .fontWeight(.heavy)
                           .foregroundColor(.primary)
                           .padding(.leading,5)
    //                       .fontDesign(.)
                        Spacer()
                        Button(action: {
                            //bu sectiondaki tum sertifikalari listede
                            selectedSectionID = "2"
                            showAll.toggle()
    //
                        }, label: {
                            Image(systemName: "ellipsis")
                                .font(.title3)
                                .fontWeight(.heavy)

                        })
                        .foregroundColor(.primary)
                        .padding(.leading,5)
                        .padding(.trailing,20)
                        }
                        .padding(.all, 6)
                        .fullScreenCover(isPresented: $showAll, content: {
                            if let sectionID = selectedSectionID {
                                                   ShowAllCertificatesView(sectionID: sectionID, dataArrayObject: getSectionDataArrayObject(for: sectionID))
                                               }
                        })
                     
                    
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
                     Text("Computer Related Certificates")
                          .font(.title3)
                          .fontWeight(.heavy)
                           .foregroundColor(.primary)
                           .padding(.leading,5)
    //                       .fontDesign(.)
                        Spacer()
                        Button(action: {
                            //bu sectiondaki tum sertifikalari listede
                            selectedSectionID = "3"
                            showAll.toggle()
    //
                        }, label: {
                            Image(systemName: "ellipsis")
                                .font(.title3)
                                .fontWeight(.heavy)

                        })
                        .foregroundColor(.primary)
                        .padding(.leading,5)
                        .padding(.trailing,20)
                        }
                        .padding(.all, 6)
                        .fullScreenCover(isPresented: $showAll, content: {
                            if let sectionID = selectedSectionID {
                                                   ShowAllCertificatesView(sectionID: sectionID, dataArrayObject: getSectionDataArrayObject(for: sectionID))
                                               }
                        })
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
       private func getSectionDataArrayObject(for sectionID: String) -> DataArrayObject {
           switch sectionID {
           case "1":
               return section1
           case "2":
               return section2
           case "3":
               return section3
           default:
               return sectionUser // Default case or handle as needed
           }
       }
}



struct SectionView_Previews: PreviewProvider{
    
    static var previews: some View{
        SectionView(section1: DataArrayObject(forUserID: ""), section2: DataArrayObject(forUserID: ""), section3: DataArrayObject(forUserID: ""), sectionUser: DataArrayObject(forUserID: ""))
            .previewLayout(.sizeThatFits)
    }
}
