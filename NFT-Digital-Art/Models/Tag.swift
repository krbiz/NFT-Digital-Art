import Foundation

struct Tag: Identifiable, Codable {
    var id = UUID()
    let text: String
}

// MARK: - Fake data

extension Tag {
    static func generate() -> [Tag] {
        let t1 = Tag(text: "Trending")
        let t2 = Tag(text: "Art")
        let t3 = Tag(text: "Entertainment")
        let t4 = Tag(text: "Gaming")
        let t5 = Tag(text: "Collectibles")
        let t6 = Tag(text: "Esports")
        let t7 = Tag(text: "NFT for Good")
        return [t1, t2, t3, t4, t5, t6, t7]
    }
}
