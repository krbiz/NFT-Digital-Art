import Foundation

struct Seller: Codable {
    let name: String
    let address: String
    let profileImage: String
}

// MARK: - Fake data

extension Seller {
    static func fakeData() -> [Seller] {
        let s1 = Seller(name: "Moodszn",
                        address: "0xC8c0843f1FA7bDaE072352F59852aa70f054067D",
                        profileImage: "image-moodszn")
        
        let s2 = Seller(name: "Azuki",
                        address: "0x9DbDc307FDE34494FAdE0EC7968b516a17aE54aF",
                        profileImage: "image-azuki")
        
        let s3 = Seller(name: "Cool Cats NFT",
                        address: "0xb815570ce5dd2cd0baa36cf34af582e7c9b67b53",
                        profileImage: "image-cats")
        
        let s4 = Seller(name: "Moonbirds",
                        address: "0x51070ee33e716973ead7416222a96bad24fc096b",
                        profileImage: "image-moonbirds")
        
        let s5 = Seller(name: "Scenic city",
                        address: "0x061d13fb1f50c30fd33ad9f036ab404e3010023d",
                        profileImage: "image-scenic")
        
        let s6 = Seller(name: "Cosmodinos Alpha",
                        address: "0x6B993428cDb4162CaC6d9749ABb352442Cec760b",
                        profileImage: "image-cosmodinos")
        
        return [s1, s2, s3, s4, s5, s6]
    }
}
