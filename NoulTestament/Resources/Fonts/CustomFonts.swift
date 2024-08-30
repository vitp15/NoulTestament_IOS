//
//  CustomFonts.swift
//  NoulTestament
//
//  Created by Vadim on 29/08/2024.
//

import SwiftUI

enum CustomFonts: String {
    case roboto = "Roboto"
    
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
    static func roboto(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let fontName: String
        switch weight {
        case .medium:
            fontName = "Roboto-Medium"
        case .bold:
            fontName = "Roboto-Bold"
        case .regular:
            fontName = "Roboto-Regular"
        default:
            fontName = "Roboto-Regular"
        }
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
    }
}
