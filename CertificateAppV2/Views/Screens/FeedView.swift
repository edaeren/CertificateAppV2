//
//  FeedView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 14.03.2024.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            PostView()
            PostView()
            PostView()
            PostView()
        })
        //this shows up only if we're in a navigation view so we put the FeedView() into the NavigationView{} down below
        .navigationBarTitle("FEED VIEW")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct FeedView_Previews: PreviewProvider{
    
    static var previews: some View{
        NavigationView {
            FeedView()
        }
    }
}
/*  that does the same thing above
#Preview {
    NavigationView{
        FeedView()
    }
    
}*/
