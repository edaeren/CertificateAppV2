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
    
    //bunu fotograf icin olan haline degistiricez ki o foto gelsin sadece
   // @State var submissionText: String = ""
    
    var body: some View {
        VStack{
            ScrollView{
             /* Text("CERTIFICATE 1")
                    .font(.title)
                    .fontDesign(.monospaced)
                    .fontWeight(.bold)
                   // .padding(.horizontal,10)
                    .frame(width: 300, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)*/
                
               
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
    //                            showShortForm.toggle()
                               
                              /*  NavigationLink(destination: ShortFormView(), isActive: $showShortForm) {
                                     EmptyView()
                                 }*/
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
                        ShortFormView()
                    })
                    
                    
            }
            
            
           
            }
            
        /*.onAppear(perform: {
            getCertificates()
        })*/
        
        // MARK: FUNCTIONS
       
        
        /*
        HStack{
            Button(action: {
               
            }) {
                Text("BAŞVUR")
                //.background(Color.MyTheme.pinkColor)
                //.foregroundColor(.white)
                // .font(.title)
                //.fontWeight(.medium)
                //.fontDesign(.rounded)
                // .padding(.all,6)
            
                    
            }
            .accentColor(Color.MyTheme.pinkColor)*/
            /*
            Image("certificate1")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)*/
        }
    /*
    func getCertificates(){
        print("get certificates from database")
        let certificate1 = CertificateModel(certificateID: "", certificateName: "sertif1", sectionID: "", sectionName: "")
    }*/
    
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
    ContentView()
}*/
