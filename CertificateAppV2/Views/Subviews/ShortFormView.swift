//
//  ShortFormView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 1.05.2024.
//

import SwiftUI

struct ShortFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var submissionText: String = ""
    @State var placeholder: String = "Please enter the link.."
    @State private var buttonText: String = "Apply".uppercased()
    @State var applicants = ApplicantsModel(applicantID: "", userID: "", sectionID: "", link: "", certificateID: "")
//    @ObservedObject var applicantsArray = ApplicantsArrayObject()
    @EnvironmentObject var applicantsArray: ApplicantsArrayObject
    @State var certificates : CertificateModel
    
    var body: some View {
      
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.primary)

            })
            .accentColor(.black)
            .padding(.all, 20)
            .padding(.leading)
            Spacer()
            
        }//hstack
        ScrollView(.vertical){
            Text("FORM PAGE")
                .font(.title)
                .padding(.bottom,50)
            Spacer()
            Spacer()
            Text("Please enter the link to your video (which shows us that you provide all the required things to get this certificate!) to the text field for our jury to evaluate your request.")
                .padding(.bottom,30)
                .frame(maxWidth: 350)
            Spacer()
            TextField(placeholder, text: $submissionText)
                .padding()
                .frame(height: 50)
                .frame(maxWidth: 350)
                .background(Color.MyTheme.pinkColor)
//                .background(Color.white)
//                .border(Color.black)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
            
            Spacer()
            Button(action: {
                //eger butona basildiysa istek listesine kisinin istegi dusmeli
                //textfield'da yazilan linki al ve applicantsArray'e at icindekini (link degiskeni)
                //sectionID ve certificateID gelmeli sertifikadan
                //userID , photoName al applicantsArray'e at
                buttonText = "Applied!".uppercased()
                //appendApplicantToArray()
                appendApplicantToDatabase()
                   
//                print("userID: \(applicants.userID) link:\(applicants.link) certificateID: \(applicants.certificateID) sectionID: \(applicants.sectionID)")
                print("array: \(applicantsArray.section1Array)")
                
            }, label: {
                Text(buttonText)
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding()
                    .frame(height: 40)
                    .frame(maxWidth: 170)
                    .background(Color.gray)
                    .cornerRadius(12)
            })
            .accentColor(Color.black)
            
            
            
        } //scroll view
       
    } //body view
    
    //userID, photoName gelmeli
    
    func appendApplicantToArray(){
        if let userID = UserDefaults.standard.string(forKey: CurrentUserDefaults.userID) {
            applicants.userID = userID
            applicants.link = submissionText
            applicants.certificateID = certificates.certificateID
            applicants.sectionID = certificates.sectionID
            applicantsArray.addApplicant(applicants)
//            applicantsArray.applicantsArray.append(applicants)
           /* print("userID: \(applicants.userID)")
            print("link: \(applicants.link)")
            print("certificateID: \(applicants.certificateID)")
            print("sectionID: \(applicants.sectionID)")*/
                  
//            print("userID: \(applicants.userID) link:\(applicants.link) certificateID: \(applicants.certificateID) sectionID: \(applicants.sectionID)")
           
        }
        else{
            
        }
    }
    
    func appendApplicantToDatabase(){
        if let userID = UserDefaults.standard.string(forKey: CurrentUserDefaults.userID) {
            ApplicantService.instance.createApplicant(userID: userID, sectionID:certificates.sectionID , link: submissionText, certificateID: certificates.certificateID)
        }
    }
    
}//endis view

#Preview {
    NavigationView{
        ShortFormView(certificates: CertificateModel(certificateID: "exampleCertificateID", certificateName: "",sectionID: "1", sectionName: "")).environmentObject(ApplicantsArrayObject.shared)
    }
}
