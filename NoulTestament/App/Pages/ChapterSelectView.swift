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
    
    var body: some View {
        List {
            ForEach(1...book.chapters, id: \.self) { chapter in
                ZStack {
                    ChapterItemView(book: book, chapter: chapter)
                }
                .listRowBackground(Color.clear)
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
        .frame(maxWidth: 700)
        .listStyle(PlainListStyle())
        .background(ZStack {
            Image(.chapter_walpaper)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .aspectRatio(contentMode: .fill)
                .scaleEffect(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/, anchor: .bottomTrailing)
                .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
            
            Color(.above_walpapers)
                .edgesIgnoringSafeArea(.all)
        })
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.width > 70 {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
        )
        .navigationBarHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
        .navigationTitle(book.name)
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
        ChapterSelectView(book: Book(order: 1, name: "Matei", chapters: 28))
    }
}
