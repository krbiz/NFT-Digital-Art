import SwiftUI

extension Font {
    enum Oswald: String {
        case black = "Oswald-Bold"
        case extraLight = "Oswald-ExtraLight"
        case light = "Oswald-Light"
        case medium = "Oswald-Medium"
        case regular = "Oswald-Regular"
        case semiBold = "Oswald-SemiBold"
    }
    
    static func oswald(_ name: Oswald = .regular, size: CGFloat) -> Font {
        return Font.custom(name.rawValue, size: size)
    }
}
