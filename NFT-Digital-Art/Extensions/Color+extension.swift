import SwiftUI

extension Color {
    enum Name: String {
        case purple = "Purple"
        case black = "Black"
        case yellow = "Yellow"
    }
    
    static func custom(_ type: Name) -> Color {
        return Color(type.rawValue)
    }
}
