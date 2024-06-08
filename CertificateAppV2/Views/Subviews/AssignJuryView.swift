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

    // Filtering juries based on sectionID
       var filteredJuries: [UserModel] {
           listOfJuries.userArray.filter { $0.juryExpert == sectionID }
       }
    /*
    if let juryExpert = user.juryExpert, juryExpert == sectionName {
        return listOfJuries.section1Array // section1'de atiyorum yemekle alakali expert olan juriler tutulacak
    }*/
    
    
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
        ScrollView{
            Text("Admin will assign juries here")
            Text("Juries which can evaluate the application:")
            Text("Experts in .... section:")
            
            //ekrana istenilen alanda uzman jurilerin userID'leri getirilecek
            VStack{
                List(filteredJuries, id: \.self) { jury in
                    Text(jury.userID)
                   
                }
            }
            
            
            
        }
        
    }
}

#Preview {
    AssignJuryView(sectionID: "exampleSection")
           .environmentObject(ApplicantsArrayObject.shared)
}
