//
//  Note.swift
//  NoulTestament
//
//  Created by Vadim on 03/09/2024.
//

import SwiftUI

class Note: Codable, ObservableObject, Identifiable, Hashable {
    let character: Character
    let atTime: TimeInterval
    @Published var message: String
    
    init(character: Character, atTime: TimeInterval, message: String = "") {
        self.character = character
        self.atTime = atTime
        self.message = message
    }
    
    enum CodingKeys: String, CodingKey {
        case character
        case atTime
        case message
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode character as a single character string
        let characterString = try container.decode(String.self, forKey: .character)
        if let firstCharacter = characterString.first, characterString.count == 1 {
            character = firstCharacter
        } else {
            character = Character.init("A")
        }
        
        atTime = try container.decode(TimeInterval.self, forKey: .atTime)
        message = try container.decode(String.self, forKey: .message)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        // Encode character as a string
        try container.encode(String(character), forKey: .character)
        try container.encode(atTime, forKey: .atTime)
        try container.encode(message, forKey: .message)
    }
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.character == rhs.character && lhs.atTime == rhs.atTime
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(character)
        hasher.combine(atTime)
    }
}

func createKey(order: Int, chapter: Int) -> String {
    "\(order) \(chapter)"
}

func getOrder(key: String) -> Int? {
    let components = key.split(separator: " ")
    guard components.count == 2,
          let order = Int(components[0]) else {
        return nil
    }
    return order
}

func getChapter(key: String) -> Int? {
    let components = key.split(separator: " ")
    guard components.count == 2,
          let chapter = Int(components[1]) else {
        return nil    }
    return chapter
}
