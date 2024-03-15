//
//  ContentView.swift
//  CertificateAppV2
//
//  Created by Eda Eren on 13.03.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            //feed view yazisinin gozukmesi icin navigation view icine aldik feed view u
            NavigationView{
                FeedView(sections: SectionArrayObject())
            }
                .tabItem {
                    Image(systemName: "rosette")
                    Text("Home Page")
                }
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            Text("Form")
                .tabItem {
                    Image(systemName: "book.pages")
                    Text("Form")
                }
            Text("Profile")
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .accentColor(Color.MyTheme.pinkColor)
    }
}

#Preview {
    ContentView()
}
