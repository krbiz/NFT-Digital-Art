import SwiftUI

struct SelectableButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack(alignment: .leading) {
            configuration.label
            
            if configuration.isPressed {
                Color.custom(.purple).opacity(0.2)
            }
        }
    }
}
