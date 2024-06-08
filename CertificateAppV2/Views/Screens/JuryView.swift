//
//  JuryView.swift
//  CertificateAppV2
//
//  Created by Taha  Adıgüzel on 8.06.2024.
//
//
import SwiftUI

struct JuryView: View {

    @EnvironmentObject var array: ApplicantsArrayObject
    @State var sectionID : String = ""
    @State var applicantID : String = ""
    @State var showAssignJuryPage: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {

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
                                    applicantID = data.applicantID
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
                                   
                                  
                                    AssignJuryView(sectionID: sectionID, applicantID: applicantID)
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

                                Text(data.userID)
                                Spacer()
                                Spacer(minLength: 170)
                                
                                Button(action: {
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
                                    applicantID = data.applicantID
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
                                    AssignJuryView(sectionID: sectionID, applicantID: applicantID)
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

                        ForEach(array.section2Array, id : \.self){data in
                            
                            HStack {
                                Text(data.userID)
                                Spacer()
                                Spacer(minLength: 170)
                                Button(action: {
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
                                    applicantID = data.applicantID
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
                                    
                                    AssignJuryView(sectionID: sectionID, applicantID: applicantID)
                                        .environmentObject(ApplicantsArrayObject.shared)
                                })}
                        
                    }
                }
            }.onAppear{
                ApplicantsArrayObject.shared.updateSectionFromOutside()
            }
        }
        
    }
    
}

#Preview {
    ApplicantsView()
    .environmentObject(ApplicantsArrayObject.shared)
}
