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
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @ObservedObject var section1 : DataArrayObject
    var profileUserID: String
    
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false, content:{
            ProfileHeaderView(profileDisplayName: $profileDisplayName, profileImage: $profileImage,certificateNumber: $certificateNumber)
           Spacer()
           Spacer()
            
            VStack{
                HStack {
                 Text("Sahip Olunan Sertifikalar")
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
            getProfileImage()
            sertifikalar()
            
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
    
    func getCertificateInformations(forCertificateID certificateID:String){
        DataService.instance.getCertificateInfoForDataArray(forCertificateID: certificateID){(certificateName,sectionID,sectionName) in
            let name = certificateName
            let id = sectionID
            let sName = sectionName
        }
    }
}

struct ProfileView_Previews: PreviewProvider{
    static var previews: some View{
        NavigationView{
            ProfileView(profileDisplayName:"joe", certificateNumber:"4", section1: DataArrayObject(forUserID: ""), profileUserID: "")
        }
    }
}
