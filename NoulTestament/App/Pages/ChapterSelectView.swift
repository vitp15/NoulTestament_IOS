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
        let items = ["first", "Faptele Apostolilor 34", "third"]
        List {
            ForEach(items, id: \.self) { item in
                ZStack {
                    NavigationLink(
                        destination: AudioView(),
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
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.width > 70 {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
        )
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
        ChapterSelectView(book: Book(path: "Matei"))
    }
}
