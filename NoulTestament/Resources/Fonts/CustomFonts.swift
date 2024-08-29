//
//  CustomFonts.swift
//  NoulTestament
//
//  Created by Vadim on 29/08/2024.
//

import SwiftUI

enum CustomFonts: String {
    case roboto_regular = "Roboto-Regular"
    case roboto_medium = "Roboto-Medium"
    
}

extension Font {
    static func custom(_ customFonts: CustomFonts, size: CGFloat) -> Font {
        Font.custom(customFonts.rawValue, fixedSize: size)
    }
}

extension Text {
    func font(_ customFonts: CustomFonts, size: CGFloat) -> Text {
        self.font(Font.custom(customFonts, size: size))
    }
}

extension UIFont {
    convenience init?(_ customFonts: CustomFonts, size: CGFloat) {
        self.init(name: customFonts.rawValue, size: size)
    }
}
