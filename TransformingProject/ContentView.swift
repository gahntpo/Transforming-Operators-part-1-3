//
//  ContentView.swift
//  TransformingProject
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            QuotesView()
                .tabItem { Text("Quotes") }
            
            ImageView()
                .tabItem { Text("Image") }
            
            ImageCollectionView()
                .tabItem { Text("Collection") }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
