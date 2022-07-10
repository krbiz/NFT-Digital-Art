import SwiftUI
import Alamofire
import Kingfisher
import Introspect

struct DashboardView: View {
    @State var isFetched: Bool = false
    @State var selectedTag: String = Tag.generate().first?.text ?? ""
    @State var nfts: [Nft] = []
    @State var showDetails: Bool = false
    @State var selectedNft: Nft?
    let sellers: [Seller] = Seller.fakeData()
    let tags: [Tag] = Tag.generate()
    @AppStorage("favourites") var favourites: Set<String> = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    ZStack {
                        Text("MARKETPLACE")
                            .font(.oswald(.regular, size: 16))
                            .foregroundColor(.white)
                        
                        HStack {
                            Spacer()
                            
                            NavigationLink {
                                FilteredView(nfts: $nfts, seller: nil)
                            } label: {
                                Image("icon-heart")
                                    .frame(width: 44, height: 44)
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                    
                    Color.white.opacity(0.2)
                        .frame(height: 0.5)
                }
                
                ScrollView {
                    if isFetched {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            tagsView()
                                .padding(.top, 20)
                            
                            Text("TOP SELLERS")
                                .font(.oswald(.medium, size: 18))
                                .foregroundColor(.white)
                                .padding(.top, 28)
                                .padding(.horizontal, 20)
                            
                            sellersView()
                                .padding(.top, 16)
                            
                            Text("COLLECTIONS")
                                .font(.oswald(.medium, size: 18))
                                .foregroundColor(.white)
                                .padding(.top, 28)
                                .padding(.horizontal, 20)
                            
                            nftsView()
                                .padding(.top, 20)
                                .padding(.horizontal, 20)
                        }
                    }
                }
                .introspectScrollView { scrollView in
                    scrollView.indicatorStyle = .white
                }
            }
            .background(
                ZStack {
                    Image("image-bg")
                        .resizable()
                        .scaledToFill()
                    
                    if !isFetched {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .opacity(0.5)
                    }
                }
                    .ignoresSafeArea()
            )
            .navigationBarHidden(true)
        }
        .onAppear {
            fetchData()
        }
    }
    
    private func tagsView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(tags) { tag in
                    TagView(text: tag.text, isSelected: .constant(selectedTag == tag.text)) { tag in
                        selectedTag = tag
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    private func sellersView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(sellers, id: \.address) { seller in
                    NavigationLink {
                        FilteredView(nfts: $nfts, seller: seller)
                    } label: {
                        Image(seller.profileImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 72, height: 72)
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    private func nftsView() -> some View {
        let nftsByTag = nfts.filter({ $0.tag?.text == selectedTag }).sorted(by: >)
        return VStack(spacing: 16) {
            ForEach(nftsByTag, id: \.identifier) { nft in
                ZStack(alignment: .topTrailing) {
                    Button {
                        selectedNft = nft
                        showDetails = true
                    } label: {
                        HStack(spacing: 10) {
                            ZStack {
                                Color.white.opacity(0.1)
                                
                                KFImage(URL(string: nft.media.first?.gateway ?? ""))
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                            }
                            .frame(width: 120.sizeW, height: 114.sizeW)
                            .cornerRadius(8)
                            .padding(5)
                            
                            VStack(alignment: .leading, spacing: 12.sizeW) {
                                HStack(spacing: 4) {
                                    Image(nft.seller?.profileImage ?? "")
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 20, height: 20)
                                    
                                    Text(nft.seller?.name ?? "")
                                        .font(.system(size: 12, weight: .light))
                                        .foregroundColor(.white.opacity(0.6))
                                        .lineLimit(1)
                                }
                                
                                Text(nft.title ?? "No title")
                                    .font(.oswald(size: 20))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                
                                HStack(spacing: 12) {
                                    Text("PRICE")
                                        .font(.oswald(size: 14))
                                        .foregroundColor(.white.opacity(0.6))
                                    
                                    Text(String(format: "%.2f", Double(nft.title?.utf8.first ?? 0) / 10))
                                        .font(.oswald(.semiBold, size: 20))
                                        .foregroundColor(.yellow)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .padding(.trailing, 16)
                        }
                        .background(
                            Color.white.opacity(0.01)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white.opacity(0.16), lineWidth: 2)
                        )
                    }
                    .buttonStyle(SelectableButtonStyle())
                    
                    Button {
                        let index = nfts.firstIndex(where: { $0.title == nft.title })!
                        let isFavourite = nfts[index].isFavourite ?? false
                        if isFavourite {
                            nfts[index].isFavourite = false
                            favourites.remove(nft.title ?? "")
                        } else {
                            nfts[index].isFavourite = true
                            favourites.insert(nft.title ?? "")
                        }
                    } label: {
                        Image(nft.isFavourite == true ? "icon-heart-fill" : "icon-heart-empty")
                            .frame(width: 45, height: 45)
                    }
                }
            }
        }
        .overlay(
            NavigationLink(isActive: $showDetails, destination: {
                if let nft = selectedNft {
                    DetailsView(nft: nft, nfts: $nfts)
                }
            }, label: {
                EmptyView()
            })
        )
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        var nfts = [Nft]()
        
        for seller in sellers {
            group.enter()
            AF.request("https://eth-mainnet.alchemyapi.io/v2/demo/getNFTs/?owner=\(seller.address)").responseDecodable(of: NftsData.self) { response in
                defer {
                    group.leave()
                }
                guard let sellerNfts = response.value?.ownedNfts else {
                    print(response)
                    return
                }
                var filteredNfts = sellerNfts.filter { URL(string: $0.media.first?.gateway ?? "") != nil }
                filteredNfts.indices.forEach {
                    let nft = filteredNfts[$0]
                    filteredNfts[$0].seller = seller
                    let index = Int((nft.title?.utf8.first ?? 0)) % tags.count
                    filteredNfts[$0].tag = tags[index]
                    filteredNfts[$0].isFavourite = favourites.contains(nft.title ?? "")
                }
                nfts.append(contentsOf: filteredNfts)
            }
        }
        
        group.notify(queue: .main) {
            isFetched = true
            self.nfts = nfts.shuffled()
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView()
            DashboardView()
                .previewDevice("iPhone 8")
            DashboardView()
                .previewDevice("iPod touch (7th generation)")
        }
    }
}
