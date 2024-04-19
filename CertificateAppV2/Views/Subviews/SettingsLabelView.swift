//
//  SettingsLabelView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 19.04.2024.
//

import SwiftUI

struct SettingsLabelView: View {
    var labelText: String
    var labelImage: String
    
    var body: some View {
        VStack {
            HStack{
                Text(labelText)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: labelImage)
            }
        }
        
        Divider()
            .padding(.vertical,4)
    }
}

#Preview {
    SettingsLabelView(labelText: "Text label", labelImage: "heart")
        .previewLayout(.sizeThatFits)
}
