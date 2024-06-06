//
//  ApplicantsView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 26.04.2024.
//

import SwiftUI

struct ApplicantsView: View {
    //this list will be the applicant list
    @ObservedObject var listOfApplicants : UserArrayObject
    @ObservedObject var section1 : UserArrayObject
    @ObservedObject var section2 : UserArrayObject
    @ObservedObject var section3 : UserArrayObject
//    @State var searchText = ""
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
                }
                .padding(.all, 6)
                // MARK: YEMEK SERTIFIKALARI SCROLLVIEWI
                ScrollView(.horizontal){
                    VStack{
                        //                ForEach(sections)  sectionlari icinde tutan arrayi gezerek tek bir baslik saglama
                        ForEach(section1.section1Array, id : \.self){data in
                            
                            HStack {
                                Image(data.photoName)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(130)
                                
                                Text(data.userName)
                                Spacer()
                                Spacer(minLength: 170)
                                Image(systemName: "xmark")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                Spacer()
                                Spacer()
                                Button(action: {
                                    //assignjuryview'a gidecek sekilde degistir
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
                                .frame(maxWidth: .infinity)
                                .cornerRadius(21)
                                .fixedSize()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 30)
                                .fullScreenCover(isPresented: $showAssignJuryPage, onDismiss: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }, content: {
                                    AssignJuryView()
                                })
                            /*
                             .fixedSize()
                             .frame(maxWidth: .infinity, alignment: .leading)
                             .padding(.leading, 30)*/
                            
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
                // MARK: YEMEK SERTIFIKALARI SCROLLVIEWI
                ScrollView(.horizontal){
                    VStack{
                        //                ForEach(sections)  sectionlari icinde tutan arrayi gezerek tek bir baslik saglama
                        ForEach(section2.section2Array, id : \.self){data in
                            
                            HStack {
                                Image(data.photoName)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(130)
                                
                                Text(data.userName)
                                Spacer()
                                Spacer(minLength: 170)
                                /*
                                Button(action: {
                                    //arraydan silecek carpiya basinca
                                    showAssignJuryPage.toggle()
                                }, label: {
                                    Image(systemName: "xmark")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                    
                                })
                                .accentColor(.black)*/
                                
                                Image(systemName: "xmark")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                Spacer()
                                Spacer()
                                Button(action: {
                                    //assignjuryview'a gidecek sekilde degistir
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
                                .frame(maxWidth: .infinity)
                                .cornerRadius(21)
                                .fixedSize()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 30)
                                .fullScreenCover(isPresented: $showAssignJuryPage, onDismiss: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }, content: {
                                    AssignJuryView()
                                })}
                          /*  NavigationLink(
                                destination: AssignJuryView(),
                                label: {
                                    HStack {
                                        Image(data.photoName)
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(130)
                                        Text(data.userName)
                                        Spacer()
                                    }.frame(height: 40).background(.bar)
                                        .padding(.all,3)
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(21)
                                })
                        }.fixedSize()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 30)*/
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
                        ForEach(section3.section3Array, id : \.self){data in
                            
                            HStack {
                                Image(data.photoName)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(130)
                                
                                Text(data.userName)
                                Spacer()
                                Spacer(minLength: 170)
                                Image(systemName: "xmark")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                Spacer()
                                Spacer()
                                Button(action: {
                                    //assignjuryview'a gidecek sekilde degistir
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
                                .frame(maxWidth: .infinity)
                                .cornerRadius(21)
                                .fixedSize()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 30)
                                .fullScreenCover(isPresented: $showAssignJuryPage, onDismiss: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }, content: {
                                    AssignJuryView()
                                })}
                            /*
                            NavigationLink(
                                destination: AssignJuryView(),
                                label: {
                                    HStack {
                                        Image(data.photoName)
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(130)
                                        Text(data.userName)
                                        Spacer()
                                    }.frame(height: 40).background(.bar)
                                        .padding(.all,3)
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(21)
                                })
                        }.fixedSize()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 30)
                        */
                        
                    }
                }
            }
        }
        
    }
    
    /*
    struct ApplicantsView_Previews: PreviewProvider{
        static var previews: some View{
            ApplicantsView(listOfApplicants: UserArrayObject(), section1: UserArrayObject(), section2: UserArrayObject(), section3: UserArrayObject())
                .previewLayout(.sizeThatFits)
        }
    }*/
}

#Preview {
    ApplicantsView(listOfApplicants: UserArrayObject(), section1: UserArrayObject(), section2: UserArrayObject(), section3: UserArrayObject())
}
