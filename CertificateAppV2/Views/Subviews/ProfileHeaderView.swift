//
//  ProfileHeaderView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 19.04.2024.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10, content: {
            // MARK: PROFILE PICTURE
           Image("food1")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120, alignment: .center)
                .cornerRadius(60)
            // MARK: USERNAME
            Text("USERNAME HERE")
                .font(.largeTitle)
                .fontWeight(.bold)
            // MARK: BIO
            Text("user can add a bio here")
                .font(.body)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
            
            HStack(alignment: .center, spacing: 20, content: {
                // MARK: NUMBER OF CERTIFICATES
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5, content: {
                    Text("5")
                        .font(.title2)
                        .fontWeight(.bold)
                    //divider between number and the "certificate"
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2, alignment: .center)
                    Text("Certificates")
                        .font(.callout)
                        .fontWeight(.medium)
                   
                })
            })
        })
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    ProfileHeaderView()
        .previewLayout(.sizeThatFits)
}
