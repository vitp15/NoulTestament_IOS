//
//  Storage.swift
//  NoulTestament
//
//  Created by Vadim on 03/10/2024.
//

import SwiftUI

class Storage: ObservableObject {
    static let instance = Storage()
    @Published var books: [Book]
    @Published var notes: [String: [Note]]
    
    private init() {
        self.books = getAllBooks()
        self.notes = loadNotes()
    }
    
    func saveNotes() {
        if let encodedData = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encodedData, forKey: "notes")
        }
    }
    
    func notesFromKey(for key: String) -> Binding<[Note]> {
        Binding(
            get: {
                self.notes[key, default: []]
            },
            set: { newValue in
                self.notes[key] = newValue
            }
        )
    }
    
    func existAtTime(key: String, time: TimeInterval, interval: TimeInterval) -> Bool {
        guard let key_notes = notes[key] else { return false }
        for note in key_notes {
            if abs(note.atTime - time) <= interval {
                return true
            }
        }
        return false
    }
    
    func hasLessNotesThan(key: String, nr: Int) -> Bool {
        guard let key_notes = notes[key],
              key_notes.count >= nr else { return true }
        return false
    }
}

func saveCurrentTime(time: TimeInterval, book: Book, currentChapter: Int) {
    UserDefaults.standard.set(time, forKey: book.getAudioName(chapter: currentChapter))
}

func saveForceClosed(bookOrder: Int, currentChapter: Int) {
    UserDefaults.standard.set("\(bookOrder) \(currentChapter)", forKey: "ForceClosed")
}

func loadCurrentTime(book: Book, currentChapter: Int) -> TimeInterval {
    if UserDefaults.standard.object(forKey: book.getAudioName(chapter: currentChapter)) != nil {
        return UserDefaults.standard.double(forKey: book.getAudioName(chapter: currentChapter))
    } else {
        return 0.0
    }
}

func loadLastForceClosed() -> String? {
    return UserDefaults.standard.string(forKey: "ForceClosed")
}

func removeCurrentTime(book: Book, currentChapter: Int) {
    if UserDefaults.standard.object(forKey: book.getAudioName(chapter: currentChapter)) != nil {
        UserDefaults.standard.removeObject(forKey: book.getAudioName(chapter: currentChapter))
    }
}

func removeForceClosed() {
    if UserDefaults.standard.object(forKey: "ForceClosed") != nil {
        UserDefaults.standard.removeObject(forKey: "ForceClosed")
    }
}

private func getAllBooks() -> [Book] {
    [
        Book(order: 1, name: "Matei", chapters: 28),
        Book(order: 2, name: "Marcu", chapters: 16),
        Book(order: 3, name: "Luca", chapters: 24),
        Book(order: 4, name: "Ioan", chapters: 21),
        Book(order: 5, name: "Faptele Apostolilor", chapters: 28),
        Book(order: 6, name: "Romani", chapters: 16),
        Book(order: 7, name: "1 Corinteni", chapters: 16),
        Book(order: 8, name: "2 Corinteni", chapters: 13),
        Book(order: 9, name: "Galateni", chapters: 6),
        Book(order: 10, name: "Efeseni", chapters: 6),
        Book(order: 11, name: "Filipeni", chapters: 4),
        Book(order: 12, name: "Coloseni", chapters: 4),
        Book(order: 13, name: "1 Tesaloniceni", chapters: 5),
        Book(order: 14, name: "2 Tesaloniceni", chapters: 3),
        Book(order: 15, name: "1 Timotei", chapters: 6),
        Book(order: 16, name: "2 Timotei", chapters: 4),
        Book(order: 17, name: "Tit", chapters: 3),
        Book(order: 18, name: "Filimon", chapters: 1),
        Book(order: 19, name: "Evrei", chapters: 13),
        Book(order: 20, name: "Iacov", chapters: 5),
        Book(order: 21, name: "1 Petru", chapters: 5),
        Book(order: 22, name: "2 Petru", chapters: 3),
        Book(order: 23, name: "1 Ioan", chapters: 5),
        Book(order: 24, name: "2 Ioan", chapters: 1),
        Book(order: 25, name: "3 Ioan", chapters: 1),
        Book(order: 26, name: "Iuda", chapters: 1),
        Book(order: 27, name: "Apocalipsa", chapters: 22)
    ]
    .sorted { $0.order < $1.order }
}

private func loadNotes() -> [String: [Note]] {
    if let data = UserDefaults.standard.data(forKey: "notes"),
       let decodedNotes = try? JSONDecoder().decode([String: [Note]].self, from: data) {
        return decodedNotes
    }
    return [:]
}
