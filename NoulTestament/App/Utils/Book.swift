//
//  Book.swift
//  NoulTestament
//
//  Created by Vadim on 29/08/2024.
//

import SwiftUI

class Book {
    let order: Int
    let name: String
    let chapters: Int
    
    init(order: Int, name: String, chapters: Int) {
        self.order = order
        self.name = name
        self.chapters = chapters
    }
    
    func getAudioName(chapter: Int) -> String {
        if (1...self.chapters).contains(chapter) {
            return "\(String(format: "%02d", chapter))_\(self.name.replacingOccurrences(of: " ", with: "-"))"
        }
        else {
            return ""
        }
    }
}

func getAllBooks() -> [Book] {
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
