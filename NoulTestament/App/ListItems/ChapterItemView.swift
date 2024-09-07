//
//  BookItemView.swift
//  NoulTestament
//
//  Created by Vadim on 29/08/2024.
//

import SwiftUI

struct ChapterItemView: View {
    @ObservedObject private var storage: Storage = Storage.instance
    let book: Book
    let chapter: Int
    @State private var isNavigationActive: Bool = false
    @State private var goToNotes: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            HStack(alignment: .center, spacing: 0) {
                Image(.audio)
                Spacer()
                
                Text("\(book.name) \(chapter)")
                    .font(.roboto, size: 24)
                    .fontWeight(.medium)
                    .foregroundColor(Color(.onSurface))
                    .background(Color.clear)
                    .minimumScaleFactor(0.75)
                    .lineLimit(1)
                Spacer()
                
                if let index = book.order - 1, (0...26).contains(index),
                   let val = storage.books[index].hasNotes[chapter], val {
                    Button(action: {
                        goToNotes = true
                    }) {
                        Image(.notes)
                    }
                    .buttonStyle(PlainButtonStyle())
                } else {
                    Rectangle()
                        .foregroundColor(Color.clear)
                        .frame(width: 24)
                }
            }
            Spacer()
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.outline))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if !goToNotes {
                isNavigationActive = true
            }
        }
        .frame(height: 44)
        .background(
            ZStack {
                NavigationLink(
                    destination: NotesView(order: book.order, chapter: chapter)
                        .navigationBarBackButtonHidden(true),
                    isActive: $goToNotes,
                    label: { EmptyView() }
                ).hidden()
                NavigationLink(
                    destination: AudioView(book: book, currChapter: chapter, onPause: false)
                        .navigationBarBackButtonHidden(true),
                    isActive: $isNavigationActive,
                    label: { EmptyView() }
                ).hidden()
            }
        )
    }
}

struct ChapterItemView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterItemView(book: Book(order: 1, name: "Matei", chapters: 28), chapter: 4)
    }
}
