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
                VStack{
                    Image(uiImage: data.photo ?? certificateImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill) // Ensure the image fills its space
                     .frame(width: 230, height: 150) // Set a fixed size for the image
                      .clipped() // Clip the image to prevent overflow
                    .scaledToFit()
                    Text(data.certificateName)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                
            }
//            .frame(height: 150).background(.bar)
//                .padding(.all,10)
            .background(Color.clear) // Adjust the background color here if needed
                 .cornerRadius(10) // Apply corner radius to the container
                 .padding(8) // Add padding to the container
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
