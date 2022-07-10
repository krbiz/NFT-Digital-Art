import SwiftUI

struct TagView: View {
    let text: String
    @Binding var isSelected: Bool
    let selectedHandler: ((String) -> Void)
    
    var body: some View {
        Button {
            selectedHandler(text)
        } label: {
            Text(text)
                .font(.oswald(size: 16))
                .foregroundColor(color)
                .padding(.horizontal, 27)
                .frame(height: 35)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(color, lineWidth: 2)
                )
                .padding(1)
        }
    }
    
    private var color: Color {
        isSelected ? .custom(.purple) : .white.opacity(0.4)
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(text: "Trending", isSelected: .constant(true)) { _ in }
    }
}
