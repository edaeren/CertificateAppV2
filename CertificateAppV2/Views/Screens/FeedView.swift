//
//  FeedView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 14.03.2024.
//

import SwiftUI

struct FeedView: View {
   // @ObservedObject var datas: DataArrayObject
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @ObservedObject var section1 : DataArrayObject
    @ObservedObject var section2 : DataArrayObject
    @ObservedObject var section3 : DataArrayObject
    @ObservedObject var sectionUser: DataArrayObject
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVStack{
              //  SectionView(datas: DataArrayObject(),section1: DataArrayObject())
               
                SectionView(section1: DataArrayObject(forUserID: currentUserID ?? ""), section2: DataArrayObject(forUserID: currentUserID ?? ""), section3: DataArrayObject(forUserID: currentUserID ?? ""), sectionUser: DataArrayObject(forUserID: currentUserID ?? ""))
                /*
                ForEach(datas.dataArray, id: \.self){data in
                    SectionView(datas: DataArrayObject())  //???
                }*/
            }
            
        })
        //this shows up only if we're in a navigation view so we put the FeedView() into the NavigationView{} down below
        .navigationBarTitle("FEED VIEW")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct FeedView_Previews: PreviewProvider{
    
    static var previews: some View{
        NavigationView {
          //  FeedView(datas: DataArrayObject(),section1: DataArrayObject())
            FeedView(section1: DataArrayObject(forUserID:""), section2: DataArrayObject(forUserID:""), section3: DataArrayObject(forUserID:""), sectionUser: DataArrayObject(forUserID:""))
        }
    }
}
/*  that does the same thing above
#Preview {
    NavigationView{
        FeedView()
    }
    
}*/
