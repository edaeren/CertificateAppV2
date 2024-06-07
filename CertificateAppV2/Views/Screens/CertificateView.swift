//
//  CertificateView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 15.03.2024.
//

import SwiftUI

struct CertificateView: View {
    
    @State var certificates : CertificateModel
    @State var showShortForm: Bool = false
    @State var showSignUpPage: Bool = false
    @State var isLoggedIn: Bool = false
    
    @State var certificateImage: UIImage = UIImage(named: "logo.loading")!
    @State var certificateName: String?
    @State var description: String = ""
    @State var requirements: String = ""
//    @StateObject var applicantsArray = ApplicantsArrayObject()
   
    
    //bunu fotograf icin olan haline degistiricez ki o foto gelsin sadece
   // @State var submissionText: String = ""
    
    var body: some View {
        VStack{
            ScrollView{
                
                //MARK: - IMAGE
                Image(uiImage: certificateImage)
//                Image("food1")
                    .resizable()
                    .scaledToFill()
                    //.frame(width: 390, height: 250, alignment: .center)
                    .frame(width: 295, height: 250, alignment: .center)
                    .padding(.all,50) .padding(.horizontal,106)
               
                // MARK: - DESCRIPTION
                Text(description).padding(.horizontal,150)
                
                // MARK: - REQUIREMENTS
                //sola daya bunu
//                Spacer()
//                Spacer()
                Text("REQUIREMENTS")
                    .frame(width: 200)
                    .fontWeight(.bold)
                    .padding(.leading,5)
                Spacer()
                Text(requirements)
                    .frame(width: 300, alignment: .leading)
                    .padding(.leading,1)
                
                    VStack{
                        Button(action:{
                           checkIfLoggedIn()
                            if isLoggedIn == true {
                                showShortForm.toggle()
                               
                            }
                            else{
    //                            showSignUpPage = true
                                showSignUpPage.toggle()
                               /* NavigationLink(destination: SignUpView(), isActive: $showSignUpPage) {
                                      EmptyView()
                                }*/
                            }
                         
                               
                        }  , label: {
                            Text("Apply".uppercased())
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding()
                                .frame(height: 60)
                                .frame(maxWidth: 300)
                                .background(Color.MyTheme.blueColor)
                                .cornerRadius(12)
                                .shadow(radius: 12)
                        })
                        .accentColor(.black)
                        .padding()
                    }.onAppear(){
                        getImages()
                        getInfos()
                    }
                    .navigationBarTitle(certificates.certificateName)
                    .navigationBarTitleDisplayMode(.inline)
                    .fullScreenCover(isPresented: $showSignUpPage, content: {
                        SignUpView()
                    })
                    .fullScreenCover(isPresented: $showShortForm, content: {
//                        ShortFormView(applicantsArray: applicantsArray, certificates: certificates)
                        ShortFormView(certificates: certificates)
                    })
                    
                    
            }
            
            
           
            }
            
        /*.onAppear(perform: {
            getCertificates()
        })*/
        
        // MARK: FUNCTIONS
       
        }
    
    func checkIfLoggedIn(){
        if UserDefaults.standard.string(forKey: CurrentUserDefaults.userID) != nil{
            isLoggedIn = true
        }
        else{
            isLoggedIn = false
        }
    }
    
    func getImages(){
        ImageManager.instance.downloadCertificateImage(certificateID: certificates.certificateID) { (returnedImage) in
            if let image = returnedImage {
                self.certificateImage = image
            }
        }
    }

    func getInfos(){
        DataService.instance.getCertificateInfo(forCertificateID:certificates.certificateID) {
            (returnedDescription,returnedReq) in
            if let description = returnedDescription{
                self.description = description
            }
            if let req = returnedReq{
                self.requirements = req
            }
        }
    }
    
    } //en dis viewın parantezi

/*
#Preview {
    NavigationView{
        var certificate : CertificateModel = CertificateModel(certificateID: "", certificateName: "Sertifika1", sectionID: "",sectionName: "", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce volutpat varius elementum. In volutpat ligula ornare erat lacinia, non finibus odio vestibulum. Donec eu euismod turpis.", requirements: "gereklilikler")
//        var user : UserModel = UserModel(userID: "", userName: "user1", adminOrNot: false, photoName: "user1")
    
//        CertificateView(certificates: certificate, user: user)
        CertificateView(certificates: certificate)
     
    }
}*/
/*
struct CertificateView_Previews: PreviewProvider{
    
    static var certificate: CertificateModel = CertificateModel(certificateID:"", certificateName: "Yemek Sertifikası", sectionID: "1", sectionName: "FOOD RELATED CERTIFICATES")
    
    static var previews: some View{
//        MiniCertificateView(data: data, showHeader: true)
        CertificateView(certificates: certificate)
            .previewLayout(.sizeThatFits)
    }
}
*/
