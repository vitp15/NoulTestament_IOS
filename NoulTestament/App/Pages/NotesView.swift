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
    let creatingNote: Bool
    let createAtTime: TimeInterval
    
    init(order: Int, chapter: Int, creatingNote: Bool = false, createAtTime: TimeInterval = 0) {
        if (1...27).contains(order) {
            self.order = order
        } else {
            self.order = 1
        }
        self.chapter = chapter
        self.creatingNote = creatingNote
        if createAtTime >= 0 {
            self.createAtTime = createAtTime
        } else {
            self.createAtTime = 0
        }
    }
    
    var body: some View {
        let notes = storage.notesFromKey(for: createKey(order: order, chapter: chapter))
        
        VStack {
            List {
                ForEach(notes.wrappedValue) { note in
                    if creatingNote && note.atTime == notes.wrappedValue.first?.atTime {
                        NoteItemView(
                            note: Binding(get: {
                                note
                            }, set: { newNote in
                                if let index = notes.wrappedValue.firstIndex(where: { $0.atTime == note.atTime }) {
                                    notes.wrappedValue[index] = newNote
                                }
                            }),
                            editMode: true,
                            deleteNote: {
                                if let index = notes.wrappedValue.firstIndex(where: { $0.atTime == note.atTime }) {
                                    notes.wrappedValue.remove(at: index)
                                }
                                storage.saveNotes()
                            }
                        )
                        .listRowBackground(Color.clear)
                    } else {
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
                }
                .onDelete(perform: { indexSet in
                    notes.wrappedValue.remove(atOffsets: indexSet)
                    storage.saveNotes()
                })
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
        }
        .onAppear(perform: {
            let key: String = createKey(order: order, chapter: chapter)
            var notes_from_key = (storage.notes[key] ?? []).sorted { $0.character < $1.character }
            if creatingNote && !storage.existAtTime(key: key, time: createAtTime, interval: 0) {
                var character = Character("A")
                if let lastNote = notes_from_key.last {
                    character = lastNote.character
                    if let unicodeScalar = character.unicodeScalars.first?.value {
                        let nextValue = unicodeScalar == 90 ? 65 : unicodeScalar + 1 // 90 is "Z", 65 is "A"
                        if let nextCharacter = UnicodeScalar(nextValue) {
                            character = Character(nextCharacter)
                        }
                    }
                }
                notes_from_key.insert(Note(character: character, atTime: createAtTime), at: 0)
            }
            storage.notes[key] = notes_from_key
            storage.saveNotes()
            
        })
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
        .navigationBarHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
        .navigationTitle("\(Storage.instance.books[order - 1].name) \(chapter)")
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
        NotesView(order: 1, chapter: 2, creatingNote: false, createAtTime: 1)
    }
}
