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
                Image(certificates.photoName)
//                Image("food1")
                    .resizable()
                    .scaledToFill()
                    //.frame(width: 390, height: 250, alignment: .center)
                    .frame(width: 295, height: 250, alignment: .center)
                    .padding(.all,50) .padding(.horizontal,106)
               
                // MARK: - DESCRIPTION
                Text(certificates.description ?? "").padding(.horizontal,150)
                
                // MARK: - REQUIREMENTS
                //sola daya bunu
                Spacer()
                Spacer()
                Text("REQUIREMENTS")
                    .frame(width: 200)
                    .fontWeight(.bold)
                    .padding(.leading,5)
                Spacer()
                Text(certificates.requirements ?? "")
                    .frame(width: 300, alignment: .leading)
                    .padding(.leading,1)
            }
            
            
            Button(action:{
                showShortForm.toggle()
            }  , label: {
                Text("Başvur".uppercased())
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.blueColor)
                    .cornerRadius(12)
                    .shadow(radius: 12)
            })
            .accentColor(.black)
            .padding()
        }
        .navigationBarTitle(certificates.certificateName)
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showShortForm, content: {
            ShortFormView()
        })
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
    
    
    } //en dis viewın parantezi


/*
#Preview {
    ContentView()
}*/

#Preview {
    NavigationView{
        var certificate : CertificateModel = CertificateModel(certificateID: "", certificateName: "Sertifika1", sectionID: "",sectionName: "", photoName: "food2", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce volutpat varius elementum. In volutpat ligula ornare erat lacinia, non finibus odio vestibulum. Donec eu euismod turpis.", requirements: "gereklilikler")
    
        CertificateView(certificates: certificate)
    }
    
   
}
