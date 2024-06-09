//
//  AssignJuryView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 5.06.2024.
//

import SwiftUI

struct AssignJuryView: View {
    @ObservedObject var listOfJuries = UserArrayObject()
       @EnvironmentObject var array: ApplicantsArrayObject

       @State var juryExpert = UserModel(userID: "", userName: "", isAdmin: false, isJury: true, juryExpert: "")
       @Environment(\.presentationMode) var presentationMode

        let sectionID: String // Accepting sectionID as a parameter
        let applicantID: String
    
    // Filtering juries based on sectionID
   
        var filteredJuries: [UserModel] {
            let filtered = listOfJuries.userArray.filter { $0.juryExpert == sectionID }
            // Debug print
            print("Filtered Juries for section \(sectionID): \(filtered.map { $0.userID })")
            return filtered
        }
    
    
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
        ScrollView{
            Text("Admin will assign juries here")
            Text("Juries which can evaluate the application:")
            Text("Experts in .... section: \(sectionID)" )
            
                //ekrana istenilen alanda uzman jurilerin userID'leri getirilecek
                VStack{
                    if filteredJuries.isEmpty {
                        Text("No juries found for section \(sectionID)")
                                .foregroundColor(.red)
                    } else {
                        ForEach(filteredJuries, id: \.self) { jury in
                            HStack{
                                Text(jury.userID)
//                                Spacer()
                                Button(action: {
                                   //send request to the juries
                                    AuthService.instance.addApplicantToJury(forUserID:jury.userID, forApplicantID:applicantID)
                                    addRequestToArray(userID: jury.userID, applicantID: applicantID, sectionID: sectionID)
//                                    listOfJuries.getRequest()
                                }, label: {
                                    Image(systemName: "person.badge.plus")
                                        .font(.headline)
                                        .fontWeight(.medium)

                                })
                                .accentColor(.green)
                                .padding(.trailing,5)
                                .padding(.leading,5)
                            }
                            Spacer()
                        }
                    }
                }
        }
        .onAppear {
                    // This ensures the view updates when it appears
            print("All Juries: \(listOfJuries.userArray.map { $0.userID })")
                    _ = filteredJuries
                }
        
    }
    func addRequestToArray(userID: String, applicantID: String, sectionID: String) {
           let newRequest = ApplicantsModel(applicantID: UUID().uuidString, userID: userID, sectionID: sectionID, link: "", certificateID: applicantID)
           array.addRequest(newRequest)
       }
}

#Preview {
    AssignJuryView(sectionID: "exampleSection", applicantID: "exampleApplicant")
            .environmentObject(ApplicantsArrayObject.shared)
    
}
