//
//  ProfileView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 19.04.2024.
//

import SwiftUI

struct ProfileView: View {
    @State var showSettings: Bool = false
    @State var profileDisplayName: String
    @State var certificateNumber: String
    @State var expertID: String
    @State var isJury: Bool = false
    @State var expert: String = "Loading..."
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @ObservedObject var section1 : DataArrayObject
    var profileUserID: String
    
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false, content:{
            ProfileHeaderView(profileDisplayName: $profileDisplayName, profileImage: $profileImage,certificateNumber: $certificateNumber, expert:$expert, isJury: $isJury)
           Spacer()
           Spacer()
            
            VStack{
                HStack {
                 Text("Owned Certificates")
                        .font(.subheadline)
                      .fontWeight(.heavy)
                       .foregroundColor(.primary)
                       .padding(.leading,5)
//                       .fontDesign(.)
                    Spacer()
                Image(systemName: "ellipsis") //sagdaki uc nokta
                        .font(.headline) //belki buraya tiklayarak geri kalan sertifikalara bakilabilir. tumunu gor gibi
                    }
                    .padding(.all, 6)
            }
                
                ScrollView(.horizontal){
                    HStack{
                        ForEach(section1.sectionArrayUser, id : \.self){data in
                            NavigationLink(
                                //EGER KULLANICI KENDI PROFILINE BAKACAKSA BASVUR BUTONU GOZUKMEYECEK
                                //BASKASI BAKIYORSA GOZUKECEK
                                destination: CertificateView(certificates: data),
                                label: {
                                 MiniCertificateView(data : data)
                                })
                        }.fixedSize()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            
        })
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:

            Button(action: {
            showSettings.toggle()
            },
            label: {
                Image(systemName: "gear")
            })
                .accentColor(Color.MyTheme.pinkColor)
        )
        .onAppear(perform: {
            updateJuryStatus()
            updateExpert()
            getProfileImage()
            sertifikalar()
            convertExpert()
        })
        .sheet(isPresented: $showSettings, content: {
            SettingsView()
        })
    }
    
    //MARK: FUNCTIONS
    
    func getProfileImage(){
        ImageManager.instance.downloadProfileImage(userID: profileUserID) { (returnedImage) in
            if let image = returnedImage {
                self.profileImage = image
            }
        }
    }
    
    func sertifikalar(){
        if currentUserID != nil {
            DataService.instance.getUserCertificates(forUserID: currentUserID!){ (certificates) in
                if let certificates = certificates {
                    // Sertifika listesini ekrana yazdır
                    certificateNumber = String(certificates.count)
                }
            }
        }
    }
    
    
    
    func updateJuryStatus() {
           guard let userID = currentUserID else {
               self.isJury = false
               return
           }
           checkUserJury(forUserID: userID) { isJury in
               self.isJury = isJury
           }
       }
    
    
    func checkUserJury(forUserID userID: String, completion: @escaping (Bool) -> Void) {
            guard !userID.isEmpty else {
                print("User ID is empty.")
                completion(false)
                return
            }
            AuthService.instance.getUserIsJury(forUserID: userID) { returnedUserState in
                if let userState = returnedUserState {
                    completion(userState)
                } else {
                    completion(false)
                }
            }
        }
    
    func updateExpert(){
        guard let userID = currentUserID else {
            self.expertID = ""
            return
        }
        AuthService.instance.getJuryExpert(forUserID: userID){ (returnedExpert) in
            if let expert = returnedExpert{
                self.expertID = expert
            }
        }
    }
    
    
    func convertExpert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if self.expertID == "1" {
                self.expert = "Food"
            } else if self.expertID == "2" {
                self.expert = "Drawing"
            } else if self.expertID == "3" {
                self.expert = "Computer"
            } else {
                self.expert = "Error"
            }
        }
    }

}

struct ProfileView_Previews: PreviewProvider{
    static var previews: some View{
        NavigationView{
            ProfileView(profileDisplayName:"joe", certificateNumber:"4", expertID: "3", expert: "", section1: DataArrayObject(forUserID: ""), profileUserID: "")
        }
    }
}
