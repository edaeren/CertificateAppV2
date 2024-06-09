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
//    @ObservedObject var array: ApplicantsArrayObject
//    @State var sectionID : String = ""
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?

    @State var showGiveApprovalPage: Bool = false
    @State var userID : String = ""
    @State var applicantID : String = ""
    @State private var isLoading: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {

        ScrollView{
            VStack{
                
                // MARK: ADMINDEN GELEN ISTEKLER
                HStack {
                    Text("Request From Admin")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                        .padding(.leading,15)
                        .padding(.top,30)
                    Spacer()
                    Button(action: {
                        refreshData()
                        /*
                        ApplicantsArrayObject.shared.getApplicants()
                        ApplicantsArrayObject.shared.clearRequestList()
                        ApplicantsArrayObject.shared.getRequest(forUserID: currentUserID, completion: <#() -> Void#>)*/
                    }, label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.headline)
                            .fontWeight(.medium)

                    })
                    .accentColor(.green)
                    .padding(.top,30)
                    .padding(.trailing,20)
                }
                .padding(.all, 6)
                
                if isLoading {
                                   ProgressView("Loading...")
                                       .padding()
                } else {
                    // MARK:  SCROLLVIEW
                    ScrollView(.horizontal){
                        VStack{
                            
                            if isLoading {
                                                ProgressView("Loading...")
                                                    .padding()
                                            }else {
                                ForEach(array.requestArray, id : \.self){data in
                                    
                                    HStack {
                                        Text(data.applicantID)
                                        Spacer()
                                        Spacer(minLength: 170)
                                        Button(action: {
                                            rejectApplication(data)
                                            ApplicantsArrayObject.shared.removeRequest(userID: data.userID, applicantID:  data.applicantID)
                                        }, label: {
                                            Image(systemName: "xmark")
                                                .font(.headline)
                                                .fontWeight(.medium)
                                        })
                                        .accentColor(.black)
                                        Spacer()
                                        Spacer()
                                        Button(action: {
                                            userID = data.userID
                                            applicantID = data.applicantID
                                            showGiveApprovalPage.toggle()
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
                                        .fullScreenCover(isPresented: $showGiveApprovalPage, onDismiss: {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }, content: {
                                            GiveApprovalView(applicantID: applicantID)
                                        }
                                        )}
                            }
                            
                        }
                    }
                }
            }/*.onAppear{
//                ApplicantsArrayObject.shared.updateSectionFromOutside()
            }*/
        }.onAppear{
            /*
            ApplicantsArrayObject.shared.clearRequestList()
            ApplicantsArrayObject.shared.getRequest(forUserID: currentUserID)*/
            refreshData()
        }
        
    }
    
    private func refreshData() {
            isLoading = true
            ApplicantsArrayObject.shared.clearRequestList()
            ApplicantsArrayObject.shared.getRequest(forUserID: currentUserID) {
                isLoading = false
            }
        }
    func rejectApplication(_ applicant: ApplicantsModel) {
            AuthService.instance.removeRequestFromJury(forUserID: currentUserID ?? "", forApplicantID: applicant.applicantID)
       }
    
}

#Preview {
    JuryView()
    .environmentObject(ApplicantsArrayObject.shared)
}
