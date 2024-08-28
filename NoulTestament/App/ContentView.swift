//
//  ContentView.swift
//  NoulTestament
//
//  Created by Vadim on 28/08/2024.
//

import SwiftUI

struct ContentView: View {
    init() {
        // Customize the navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(.seed) ?? UIColor.green
        let onPrimaryColor = UIColor(.onPrimary) ?? UIColor.white
        appearance.titleTextAttributes = [.foregroundColor: onPrimaryColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: onPrimaryColor]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image(.books_walpaper)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
                
                Color(.above_walpapers)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Hello, SwiftUI!")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .navigationTitle("Noul Testament")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

