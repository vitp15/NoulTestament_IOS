//
//  CustomImages.swift
//  NoulTestament
//
//  Created by Vadim on 28/08/2024.
//

import SwiftUI

enum CustomColors: String {
    case above_walpapers
    case seed
    case onPrimary
    case onSurface
    case outline
    case tertiary
    case tertiaryFixedDim
}

extension Color {
    init(_ name: CustomColors) {
        self.init(name.rawValue)
    }
}

extension UIColor {
    convenience init?(_ name: CustomColors) {
        self.init(named: name.rawValue)
    }
}
