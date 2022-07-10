import Foundation

struct Nft: Codable {
    let title: String?
    let description: String?
    let media: [Media]
    let id: Id
    let metadata: Metadata?
    let contract: Contract
    var seller: Seller?
    var tag: Tag?
    var isFavourite: Bool? = false

    struct Media: Codable {
        let raw: String
        let gateway: String
    }
    
    struct Id: Codable {
        let tokenId: String
        let tokenMetadata: TokenMetadata
    }
    
    struct TokenMetadata: Codable {
        let tokenType: String
    }
    
    struct Metadata: Codable {
        let attributes: [Attribute]?
    }
    
    struct Contract: Codable {
        let address: String
    }
}

extension Nft: Hashable, Comparable {
    var identifier: String {
        return UUID().uuidString
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    static func == (lhs: Nft, rhs: Nft) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    static func < (lhs: Nft, rhs: Nft) -> Bool {
        return lhs.title ?? "" < rhs.title ?? ""
    }
}

struct NftsData: Codable {
    let ownedNfts: [Nft]
}

struct Attribute {
    let value: String
    let displayType: String
    let traitType: String
    
    enum CodingKeys: String, CodingKey {
        case value
        case displayType = "display_type"
        case traitType = "trait_type"
    }
}

// MARK: - Codable

extension Attribute: Codable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? values.decode(Int.self, forKey: .value) {
            self.value = String(value)
        } else if let value = try? values.decode(String.self, forKey: .value) {
            self.value = value
        } else {
            self.value = ""
        }
        displayType = (try? values.decode(String.self, forKey: .displayType)) ?? ""
        traitType = (try? values.decode(String.self, forKey: .traitType)) ?? ""
    }
}
