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
}

extension Image {
    init(_ name: CustomIcons) {
        self.init(name.rawValue)
    }
}
