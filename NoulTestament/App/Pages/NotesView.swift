//
//  NotesView.swift
//  NoulTestament
//
//  Created by Vadim on 03/09/2024.
//

import SwiftUI

struct NotesView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var storage = Storage.instance
    let order: Int
    let chapter: Int
    
    init(order: Int, chapter: Int) {
        if (1...27).contains(order) {
            self.order = order
        } else {
            self.order = 1
        }
        self.chapter = chapter
    }
    
    var body: some View {
        let notes = storage.notesFromKey(for: "key")
        
        VStack {
            List {
                ForEach(notes.wrappedValue) { note in
                    NoteItemView(
                        note: Binding(get: {
                            note
                        }, set: { newNote in
                            if let index = notes.wrappedValue.firstIndex(where: { $0.atTime == note.atTime }) {
                                notes.wrappedValue[index] = newNote
                            }
                        }),
                        editMode: false,
                        deleteNote: {
                            if let index = notes.wrappedValue.firstIndex(where: { $0.atTime == note.atTime }) {
                                notes.wrappedValue.remove(at: index)
                            }
                            storage.saveNotes()
                        }
                    )
                    .listRowBackground(Color.clear)
                }
                .onDelete(perform: { indexSet in
                    notes.wrappedValue.remove(atOffsets: indexSet)
                    storage.saveNotes()
                })
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
        }
        .frame(maxWidth: 700)
        .listStyle(PlainListStyle())
        .background(ZStack {
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
        .navigationTitle(Storage.instance.books[order - 1].name)
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

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(order: 1, chapter: 2)
    }
}
