//
//  SettingsEditImageView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 23.04.2024.
//

import SwiftUI

struct SettingsEditImageView: View {
    @State var title: String
    @State var description: String
    @State var selectedImage: UIImage //image shown on this screen
    @State var showImagePicker: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack{
                Text(description)
                Spacer(minLength: 0)
            }
          
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200, alignment: .center)
                .clipped()
                .cornerRadius(12)
            
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Import".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.pinkColor)
                    .cornerRadius(12)
            })
            .accentColor(Color.black)
            .sheet(isPresented: $showImagePicker , content: {
//                ImagePicker  //adam burayi onceki videolarda yapti, orayi izlemen lazim
            })
            
            
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Save".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.blueColor)
                    .cornerRadius(12)
            })
            .accentColor(Color.black)
            
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationBarTitle(title)
    }
}

#Preview {
    NavigationView{
        SettingsEditImageView(title: "Title", description: "Description", selectedImage: UIImage(named: "food1")!)
    }
  
}
