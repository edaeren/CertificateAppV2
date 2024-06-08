//
//  ApplicantsView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 26.04.2024.
//

import SwiftUI

struct ApplicantsView: View {
    //this list will be the applicant list
//    @ObservedObject var listOfApplicants : ApplicantsArrayObject
//    @ObservedObject var section1 : ApplicantsArrayObject
//    @ObservedObject var section2 : ApplicantsArrayObject
//    @ObservedObject var array : ApplicantsArrayObject
    @EnvironmentObject var array: ApplicantsArrayObject
    @State var sectionID : String = ""
//    @ObservedObject var section3 : ApplicantsArrayObject
//    @State var searchText = ""
    @State var showAssignJuryPage: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        /*
        HStack {
            Button(action: {
                ApplicantsArrayObject.shared.updateSectionFromOutside()
            }, label: {
                Image(systemName: "arrow.clockwise")
                    .font(.headline)
                    .fontWeight(.medium)

            })
            .accentColor(.green)
//            .padding(.all, 20)
//            .padding(.trailing,3)
            .padding(.top,5)
            .padding(.leading,320)
        }//hstack*/
        ScrollView{
            VStack{
                // MARK: YEMEKLE ILGILI SERTIFIKALAR
                HStack {
                    Text("Food Related Applications")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                        .padding(.top, 30)
                        .padding(.leading,15)
                    
                    Spacer()
                    Button(action: {
                        ApplicantsArrayObject.shared.updateSectionFromOutside()
                    }, label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.headline)
                            .fontWeight(.medium)

                    })
                    .accentColor(.green)
                    .padding(.top,30)
                    .padding(.trailing,20)
                    
                }
                .padding(.all, 4)
               
                // MARK: YEMEK SERTIFIKALARI SCROLLVIEWI
                ScrollView(.horizontal){
                    VStack{
                        //                ForEach(sections)  sectionlari icinde tutan arrayi gezerek tek bir baslik saglama
                        ForEach(array.section1Array, id : \.self){data in
                            
                            HStack {
                               /* Image(data.photoName)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(130)*/
                                
//                                Text(data.userName)
//                                Text(data.userID)
                                Text(data.userID)
                               
//                                print("userID: \(section1.) link:\(applicants.link) certificateID: \(applicants.certificateID) sectionID: \(applicants.sectionID)")
                                Spacer()
                                Spacer(minLength: 170)
                                Button(action: {
//                                    array.removeApplicant(data)
//                                    array.removeApplicant(userID: data.userID, sectionID: data.sectionID)
                                    array.removeApplicant(userID: data.userID, certificateID: data.certificateID)
                                    ApplicantsArrayObject.shared.deleteApplicant(applicantID: data.applicantID)
                                }, label: {
                                    Image(systemName: "xmark")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                })
                                    .accentColor(.black)
                                Spacer()
                                Spacer()
                                Button(action: {
                                    //assignjuryview'a gidecek sekilde degistir
                                    sectionID = data.sectionID
                                    showAssignJuryPage.toggle()
                                   
                                }, label: {
                                    Image(systemName: "checkmark")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                    
                                })
                                .accentColor(.green)
                                Spacer()
                            }.frame(height: 40).background(.bar)
                                .padding(.all,3)
                                .frame(maxWidth: 350)
                                .cornerRadius(21)
                                .fixedSize()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 30)
                                .fullScreenCover(isPresented: $showAssignJuryPage, onDismiss: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }, content: {
                                   
                                  
                                    AssignJuryView(sectionID: sectionID)
                                        .environmentObject(ApplicantsArrayObject.shared)
                                })
                           
                        }
                        
                    }
                    
                }
                Spacer()
                Spacer()
                
                // MARK: BILGISAYARLA ILGILI SERTIFIKALAR
                HStack {
                    Text("Computer Related Applications")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                        .padding(.leading,15)
                    Spacer()
                }
                .padding(.all, 6)
                // MARK: BILG SERTIFIKALARI SCROLLVIEWI
                ScrollView(.horizontal){
                    VStack{
                        //                ForEach(sections)  sectionlari icinde tutan arrayi gezerek tek bir baslik saglama
                        ForEach(array.section3Array, id : \.self){data in
                            
                            HStack {
                              /*  Image(data.photoName)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(130)
                                
                                Text(data.userName)*/
                                Text(data.userID)
//                                Text(data.certificateID)
                                Spacer()
                                Spacer(minLength: 170)
                                
                                Button(action: {
//                                    array.removeApplicant(data)
//                                    array.removeApplicant(userID: data.userID, sectionID: data.sectionID)
                                    array.removeApplicant(userID: data.userID, certificateID: data.certificateID)
                                    ApplicantsArrayObject.shared.deleteApplicant(applicantID: data.applicantID)
                                }, label: {
                                    Image(systemName: "xmark")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                })
                                    .accentColor(.black)
                                Spacer()
                                Spacer()
                                Button(action: {
                                    sectionID = data.sectionID
                                    showAssignJuryPage.toggle()
                                }, label: {
                                    Image(systemName: "checkmark")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                    
                                })
                                .accentColor(.green)
                                Spacer()
                            }.frame(height: 40).background(.bar)
                                .padding(.all,3)
                                .frame(maxWidth: 350)
                                .cornerRadius(21)
                                .fixedSize()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 30)
                                .fullScreenCover(isPresented: $showAssignJuryPage, onDismiss: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }, content: {
                                    AssignJuryView(sectionID: sectionID)
                                        .environmentObject(ApplicantsArrayObject.shared)
                                })}
                    }
                }
                Spacer()
                Spacer()
                
                // MARK: CIZIMLE ILGILI SERTIFIKALAR
                HStack {
                    Text("Art Related Applications")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                        .padding(.leading,15)
                    Spacer()
                }
                .padding(.all, 6)
                // MARK: CIZIM SERTIFIKALARI SCROLLVIEWI
                ScrollView(.horizontal){
                    VStack{
                        //                ForEach(sections)  sectionlari icinde tutan arrayi gezerek tek bir baslik saglama
                        ForEach(array.section2Array, id : \.self){data in
                            
                            HStack {
                                /*
                                Image(data.photoName)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(130)*/
                                
//                                Text(data.userName)
                                Text(data.userID)
                                Spacer()
                                Spacer(minLength: 170)
                                Button(action: {
//                                    array.removeApplicant(data)
//                                    array.removeApplicant(userID: data.userID, sectionID: data.sectionID)
                                    array.removeApplicant(userID: data.userID, certificateID: data.certificateID)
                                    ApplicantsArrayObject.shared.deleteApplicant(applicantID: data.applicantID)
                                }, label: {
                                    Image(systemName: "xmark")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                })
                                    .accentColor(.black)
                                Spacer()
                                Spacer()
                                Button(action: {
                                    //assignjuryview'a gidecek sekilde degistir
                                    sectionID = data.sectionID
                                    showAssignJuryPage.toggle()
                                }, label: {
                                    Image(systemName: "checkmark")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                    
                                })
                                .accentColor(.green)
                                Spacer()
                            }.frame(height: 40).background(.bar)
                                .padding(.all,3)
                                .frame(maxWidth: 350)
                                .cornerRadius(21)
                                .fixedSize()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 30)
                                .fullScreenCover(isPresented: $showAssignJuryPage, onDismiss: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }, content: {
                                    //parametre olarak sectionID gitmeli
                                    
                                    AssignJuryView(sectionID: sectionID)
                                        .environmentObject(ApplicantsArrayObject.shared)
                                })}
                        
                    }
                }
                
                /*
                //arraye eklenmis mi diye bakmak icin yazdim
                Button(action: {
                    print("userID: \(array.section1Array) \(array.section2Array) \(array.section3Array) ")
                   
                }, label: {
                    Image(systemName: "checkmark")
                        .font(.headline)
                        .fontWeight(.medium)
                    
                })*/
            }.onAppear{
                ApplicantsArrayObject.shared.updateSectionFromOutside()
            }
        }
        
    }
    
}

#Preview {
//    ApplicantsView(listOfApplicants: ApplicantsArrayObject(), section1: ApplicantsArrayObject(), section2: UserArrayObject(), section3: UserArrayObject())
//    ApplicantsView(section1: ApplicantsArrayObject(), section2: ApplicantsArrayObject(), array: ApplicantsArrayObject())
//    ApplicantsView(array: ApplicantsArrayObject())
    ApplicantsView()
    .environmentObject(ApplicantsArrayObject.shared)
}
