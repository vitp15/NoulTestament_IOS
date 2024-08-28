//
//  CustomImages.swift
//  NoulTestament
//
//  Created by Vadim on 28/08/2024.
//

import SwiftUI

enum CustomImages: String {
    case books_walpaper
    case chapters_walpaper
    case audio_walpaper
}

extension Image {
    init(_ name: CustomImages) {
        self.init(name.rawValue)
    }
}
