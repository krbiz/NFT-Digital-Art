import SwiftUI

struct ScalableButtonStyle: ButtonStyle {
    var isScalable: Bool = true
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? (isScalable ? 0.95 : 1.0) : 1.0)
            .brightness(configuration.isPressed ? -0.05 : 0)
            .animation(.linear(duration: 0.2), value: configuration.isPressed)
    }
}
