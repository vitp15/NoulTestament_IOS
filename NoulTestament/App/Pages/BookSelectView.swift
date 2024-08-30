//
//  ContentView.swift
//  NoulTestament
//
//  Created by Vadim on 28/08/2024.
//

import SwiftUI

struct BookSelectView: View {
    let books: [Book]
    
    init() {
        books = getAllBooks()
        // Customize the navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(.seed) ?? UIColor.green
        let onPrimaryColor = UIColor(.onPrimary) ?? UIColor.white
        let customFont = UIFont(.roboto_medium, size: 22) ??
            UIFont.systemFont(ofSize: 22, weight: .medium)
        appearance.titleTextAttributes = [
            .font: customFont,
            .foregroundColor: onPrimaryColor
        ]
        appearance.largeTitleTextAttributes = [.foregroundColor: onPrimaryColor]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.order) { book in
                    ZStack {
                        NavigationLink(
                            destination: ChapterSelectView(book: book)
                                .navigationBarBackButtonHidden(true),
                            label: {}).hidden()
                        BookItemView(name: book.name)
                    }
                    .listRowBackground(Color.clear)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
            .listStyle(PlainListStyle())
            .background(
                ZStack {
                    Image(.books_walpaper)
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
                    
                    Color(.above_walpapers)
                        .edgesIgnoringSafeArea(.all)
                })
            .navigationTitle("Noul Testament")
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct BookSelectView_Previews: PreviewProvider {
    static var previews: some View {
        BookSelectView()
    }
}
