//
//  SettingsRowView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 19.04.2024.
//

import SwiftUI

struct SettingsRowView: View {
    var leftIcon: String
    var text: String
    var color: Color
    
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: leftIcon)
                    .font(.title3)
                    .foregroundColor(.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(text)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.headline)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    SettingsRowView(leftIcon: "heart.fill", text: "Row title", color: .red)
        .previewLayout(.sizeThatFits)
}
