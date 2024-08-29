//
//  ChaptersSelectView.swift
//  NoulTestament
//
//  Created by Vadim on 29/08/2024.
//

import SwiftUI

struct ChapterSelectView: View {
    let book: Book
    @Environment(\.presentationMode) var presentationMode
    
    init(book: Book) {
        self.book = book
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
        let items = ["first", "Faptele Apostolilor 34", "third"]
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    ZStack {
                        NavigationLink(
                            destination: Text(book.name),
                            label: {}).hidden()
                        ChapterItemView(name: item)
                    }
                    .listRowBackground(Color.clear)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
            .listStyle(PlainListStyle())
            .background(ZStack {
                Image(.chapter_walpaper)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
                
                Color(.above_walpapers)
                    .edgesIgnoringSafeArea(.all)
            })
            .navigationBarHidden(true)
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.width > 70 {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
        )
        .navigationTitle(book.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(.back)
                    }
                }
            }
        }
    }
}

struct ChapterSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterSelectView(book: Book(path: "Matei"))
    }
}
