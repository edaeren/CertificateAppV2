//
//  GiveApprovalView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 1.05.2024.
//

import SwiftUI

struct GiveApprovalView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var buttonText: String = "Apply".uppercased()
    @EnvironmentObject var array: ApplicantsArrayObject
    let userID: String // Accepting userID as a parameter
    
    var filteredRequest: [ApplicantsModel] {
        let filtered = array.requestArray.filter { $0.userID == userID }
        return filtered
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .fontWeight(.medium)
                })
                .accentColor(.black)
                .padding(.all, 20)
                .padding(.leading)
                Spacer()
            }
            
            ScrollView(.vertical) {
                Text("Give Approval View")
                    .font(.title)
                    .padding(.bottom, 50)
                
                VStack {
                    if filteredRequest.isEmpty {
                        Text("No requests found for userID \(userID)")
                            .foregroundColor(.red)
                    } else {
                        ForEach(filteredRequest, id: \.self) { data in
                            VStack(spacing: 20) {
                                HStack {
                                    Text(data.link)
                                        .padding(.all, 5)
                                        .frame(height: 50)
                                        .frame(maxWidth: 300)
                                        .background(Color.clear)
                                        .border(Color.black)
                                        .cornerRadius(6)
                                        .font(.headline)
//                                        .padding(.leading,30)
                                    Spacer()
                                }.padding(.all, 50)
                                
                                HStack {
                                    Button(action: {
                                        rejectApplicant(data)
                                        presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Label("REJECT", systemImage: "xmark")
                                            .font(.title3)
                                            .fontWeight(.medium)
                                            .padding()
                                            .frame(height: 50)
                                            .frame(maxWidth: 155)
                                            .background(Color.gray)
                                            .cornerRadius(12)
                                    })
                                    .accentColor(.black)
                                    
                                    Button(action: {
                                        approveApplicant(data)
                                        presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Label("APPROVE", systemImage: "checkmark")
                                            .font(.title3)
                                            .fontWeight(.medium)
                                            .padding()
                                            .frame(height: 50)
                                            .frame(maxWidth: 155)
                                            .background(Color.MyTheme.blueColor)
                                            .cornerRadius(12)
                                    })
                                    .accentColor(.black)
                                }
                            }
                        }
                    }
                }
                .padding(.top, 20)
                Spacer()
            }
        }
    }
    
    func approveApplicant(_ applicant: ApplicantsModel) {
        buttonText = "APPROVE".uppercased()
        AuthService.instance.addCertificateToUser(forUserID: applicant.userID, forCertificateID: applicant.certificateID)
        // Other logic to handle the approval...
    }
    
    func rejectApplicant(_ applicant: ApplicantsModel) {
        buttonText = "REJECT".uppercased()
        // Logic to handle rejection, such as removing the applicant from the list or database
        AuthService.instance.removeRequestFromJury(forUserID: applicant.userID, forApplicantID: applicant.certificateID)
        // Other logic to handle the rejection...
    }
}

#Preview {
    NavigationView {
        GiveApprovalView(userID: "exampleUserID")
            .environmentObject(ApplicantsArrayObject.shared)
    }
}
