//
//  Storage.swift
//  NoulTestament
//
//  Created by Vadim on 03/10/2024.
//

import SwiftUI

func saveCurrentTime(time: TimeInterval, book: Book, currentChapter: Int) {
    UserDefaults.standard.set(time, forKey: book.getAudioName(chapter: currentChapter))
}

func saveForceClosed(currentChapter: Int, bookOrder: Int) {
    UserDefaults.standard.set("\(currentChapter) \(bookOrder)", forKey: "ForceClosed")
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
