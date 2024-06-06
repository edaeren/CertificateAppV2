//
//  MiniCertificateView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 7.04.2024.
//

import SwiftUI

struct MiniCertificateView: View {
    @State var data: CertificateModel
    @State var certificateImage: UIImage = UIImage(named: "logo.loading")!
//    var showHeader: Bool
    
    var body: some View {
        HStack{
            VStack {
                // MARK: HEADER
               
//                if showHeader{
//                    HStack {
//                        Text(data.sectionName)
//                            .font(.subheadline)
//                            .fontWeight(.heavy)
//                            .foregroundColor(.primary) //changes the color depenging of the mode(dark mode or light mode)
//                        Spacer() //sola dayadik
//                        Image(systemName: "ellipsis") //sagdaki uc nokta
//                            .font(.headline) //belki buraya tiklayarak geri kalan sertifikalara bakilabilir. tumunu gor gibi
//                    }
//                    .padding(.all, 6)
//                }
                
               
                VStack{
                    Image(uiImage: data.photo ?? certificateImage)
                    .resizable()
                    .scaledToFit()
                    Text(data.certificateName)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                
            }.frame(height: 150).background(.bar)
                .padding(.all,10)
        }
        
       
    }
}

struct MiniCertificateView_Previews: PreviewProvider{
    
    static var data: CertificateModel = CertificateModel(certificateID:"", certificateName: "Yemek Sertifikası", sectionID: "1", sectionName: "FOOD RELATED CERTIFICATES")
    
    static var previews: some View{
//        MiniCertificateView(data: data, showHeader: true)
        MiniCertificateView(data: data)
            .previewLayout(.sizeThatFits)
    }
}
