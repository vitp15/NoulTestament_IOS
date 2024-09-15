//
//  NoteItemView.swift
//  NoulTestament
//
//  Created by Vadim on 03/09/2024.
//

import SwiftUI

struct NoteItemView: View {
    @Binding var note: Note
    @State private var editMode: Bool = true
    @State private var textField: String = ""
    @State private var showingAlert: Bool = false
    @State private var navigateToAudio: Bool = false
    private let order: Int
    private let chapter: Int
    private var deleteNote: () -> Void
    
    init(note: Binding<Note>, editMode: Bool, order: Int,
         chapter: Int, deleteNote: @escaping () -> Void) {
        self._note = note
        _editMode = State(initialValue: editMode)
        _textField = State(initialValue: note.wrappedValue.message)
        if (1...27).contains(order) {
            self.order = order
        } else {
            self.order = 1
        }
        self.chapter = chapter
        self.deleteNote = deleteNote
    }
    
    var body: some View {
        VStack (alignment: .center, spacing: 0, content: {
            Spacer()
            HStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                Button(action: goToAudio, label: {
                    ZStack {
                        Image(.note_icon)
                        Text(String(note.character))
                            .font(.roboto, size: 32)
                            .fontWeight(.medium)
                            .foregroundColor(Color(.white))
                            .background(Color.clear)
                            .minimumScaleFactor(0.6)
                            .lineLimit(1)
                    }
                    .frame(width: 50, height: 68, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                })
                
                if editMode {
                    TextField("Introduceți notița", text: $textField, onCommit: {
                        note.message = textField
                        Storage.instance.saveNotes()
                        editMode = false
                    })
                    .font(Font.custom(.roboto, size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .foregroundColor(Color(.onSurface))
                    .background(Color.clear)
                    .lineLimit(3)
                } else {
                    Button(action: goToAudio, label: {
                        Text(note.message)
                            .font(.roboto, size: 18)
                            .fontWeight(.regular)
                            .foregroundColor(Color(.onSurface))
                            .background(Color.clear)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                            .minimumScaleFactor(0.75)
                            .lineLimit(3)
                    })
                }
                
                if !editMode {
                    VStack {
                        Spacer()
                        Image(.edit)
                            .onTapGesture {
                                editMode = true
                            }
                        Spacer()
                        Image(.delete)
                            .onTapGesture {
                                showingAlert = true
                            }
                            .alert(isPresented: $showingAlert, content: {
                                Alert(title: Text("Șterge notița"), message: Text("Ești sigur că vrei să ștergi notița?"),
                                      primaryButton: .destructive(Text("Șterge")) {
                                        deleteNote()
                                      }, secondaryButton: .cancel(Text("Anulează")))
                            })
                        Spacer()
                    }
                }
            })
            Spacer()
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.outline))
            
        })
        .frame(height: 96)
        .background(
            NavigationLink(
                destination: AudioView(book: Storage.instance.books[order - 1],
                                       currChapter: chapter, onPause: false)
                    .navigationBarBackButtonHidden(true),
                isActive: $navigateToAudio,
                label: { EmptyView() }
            )
            .hidden())
    }
    
    private func goToAudio() {
        let book = Storage.instance.books[order - 1]
        removeCurrentTime(book: book, currentChapter: chapter)
        saveCurrentTime(time: note.atTime, book: book, currentChapter: chapter)
        navigateToAudio = true
    }
}

struct NoteItemView_Previews: PreviewProvider {
    static var previews: some View {
        let note = Note(character: Character("A"), atTime: 0, message: "String message")
        
        NoteItemView(
            note: Binding(
                get: { note },
                set: { newNote in }
            ),
            editMode: false,
            order: 1,
            chapter: 1,
            deleteNote: { }
        )
    }
}
