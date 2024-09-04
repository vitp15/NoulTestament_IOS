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
