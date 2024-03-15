//
//  SectionView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 14.03.2024.
//

import SwiftUI

struct SectionView: View {
    @State var section: CertificateModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            // MARK: HEADER
            HStack {
               
                Text(section.sectionName)
                    .font(.subheadline)
                    .fontWeight(.heavy)
                    .foregroundColor(.primary) //changes the color depenging of the mode(dark mode or light mode)
                Spacer() //sola dayadik
                Image(systemName: "ellipsis") //sagdaki uc nokta
                    .font(.headline) //belki buraya tiklayarak geri kalan sertifikalara bakilabilir. tumunu gor gibi
            }
            .padding(.all, 6)
            
            // MARK: IMAGE/SERTİFİKALAR
            ScrollView(.horizontal) {
                HStack {
                    ForEach(1..<8){index in
                        VStack{
                            Image("food"+String(index))
                            .resizable()
                            .scaledToFit()
                            Text(section.certificateName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                        }
                        
                        //Text("View \(index)")
                    }.frame(width: 240,height: 180)
                        .background(.primary)
                        .foregroundColor(.white)
                        .padding(6)
                  
                }.frame(height: 200).background(.bar)
                    .padding(.all,10)
            }
           // .flipsForRightToLeftLayoutDirection(true)
          //  .environment(\.layoutDirection, .rightToLeft)
            
            /*
            Image("dog1")
                .resizable()
                .scaledToFit()*/
            //MARK: FOOTER
                .padding(.all,6)
        })
    }
}

struct SectionView_Previews: PreviewProvider{
    
    static var section: CertificateModel = CertificateModel(certificateID:"", certificateName: "Yemek", sectionID: "", sectionName: "FOOD RELATED CERTIFICATES")
    
    static var previews: some View{
        SectionView(section: section)
            .previewLayout(.sizeThatFits)
    }
}
