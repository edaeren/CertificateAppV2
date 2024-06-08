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
    //    @EnvironmentObject var applicantsArray: ApplicantsArrayObject
    //    @State var certificates : CertificateModel
    
    var body: some View {
        
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
            
        }//hstack
        
        ScrollView(.vertical){
            
            Text("Give Approval View")
                .font(.title)
                .padding(.bottom,50)
            Spacer()
            Spacer()
            Text("kabul veya red")
                .padding(.bottom,30)
                .frame(maxWidth: 350)
            Spacer()
            //burada kullanicinin gonderdigi link yer almali
            VStack{
                ForEach(array.requestArray) { data in
                    HStack {
                        Text(data.link)
                            .padding()
                            .frame(height: 50)
                            .frame(maxWidth: 350)
                            .background(Color.MyTheme.pinkColor)
                        //                .background(Color.white)
                        //                .border(Color.black)
                            .cornerRadius(12)
                            .font(.headline)
                        Spacer()
                        Spacer(minLength: 170)
                    }
                    HStack {
                        Button(action: {
                            rejectApplicant(data)
                        }, label: {
                            Text("REJECT")
                                .font(.title3)
                                .fontWeight(.medium)
                                .padding()
                                .frame(height: 40)
                                .frame(maxWidth: 170)
                                .background(Color.gray)
                                .cornerRadius(12)
                            Image(systemName: "xmark")
                                .font(.headline)
                                .fontWeight(.medium)
                        })
                        .accentColor(.black)
                        
                        Button(action: {
                            approveApplicant(data)
                        }, label: {
                            Text("APPROVE")
                                .font(.title3)
                                .fontWeight(.medium)
                                .padding()
                                .frame(height: 40)
                                .frame(maxWidth: 170)
                                .background(Color.gray)
                                .cornerRadius(12)
                            Image(systemName: "checkmark")
                                .font(.headline)
                                .fontWeight(.medium)
                        })
                        .accentColor(.black)
                    }
                }
                Spacer()
            } //scroll view
            
            
        } //body view
        
    }//endis view
    func approveApplicant(_ applicant: ApplicantsModel) {
       buttonText = "APPROVE".uppercased()
       AuthService.instance.addCertificateToUser(forUserID: applicant.userID, forCertificateID: applicant.certificateID)
       // Other logic to handle the approval...
   }
   // Rejection function
    func rejectApplicant(_ applicant: ApplicantsModel) {
       buttonText = "REJECT".uppercased()
       // Logic to handle rejection, such as removing the applicant from the list or database
        AuthService.instance.removeRequestFromJury(forUserID: applicant.userID, forApplicantID: applicant.certificateID)
       // Other logic to handle the rejection...
   }
}

#Preview {
    NavigationView{
//        ShortFormView(certificates: CertificateModel(certificateID: "exampleCertificateID", certificateName: "",sectionID: "1", sectionName: "")).environmentObject(ApplicantsArrayObject.shared)
        GiveApprovalView()
    }
}
