//
//  CustomImages.swift
//  NoulTestament
//
//  Created by Vadim on 28/08/2024.
//

import SwiftUI

enum CustomIcons: String {
    case book
    case audio
    case back
    case arrow_back
    case forward_5
    case pause
    case play
    case replay_5
    case next = "skip_next"
    case previous = "skip_previous"
    case note_icon
    case note_flag
    case note_mark
    case edit
    case delete
    case notes
}

extension Image {
    init(_ name: CustomIcons) {
        self.init(name.rawValue)
    }
}
