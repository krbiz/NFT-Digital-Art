import SwiftUI
import Alamofire
import Kingfisher
import Introspect

struct FilteredView: View {
    @Binding var nfts: [Nft]
    @State var showDetails: Bool = false
    @State var selectedNft: Nft?
    let seller: Seller?
    @AppStorage("favourites") var favourites: Set<String> = []
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                ZStack {
                    Text(seller == nil ? "FAVOURITES" : seller?.name.uppercased() ?? "")
                        .font(.oswald(size: 16))
                        .foregroundColor(.white)
                    
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("icon-back")
                        }
                        .frame(width: 44, height: 44)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                }
                
                Color.white.opacity(0.2)
                    .frame(height: 0.5)
            }
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    nftsView()
                        .padding(.top, 20)
                        .padding(.horizontal, 20)
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
                    .ignoresSafeArea()
                
                if seller == nil && favourites.isEmpty {
                    Text("Empty favorites list")
                        .font(.oswald(size: 20))
                        .foregroundColor(.white.opacity(0.6))
                }
            }
        )
        .navigationBarHidden(true)
    }
    
    private func nftsView() -> some View {
        let nftsFiltered = nfts.filter({
            if let seller = seller {
                return $0.seller?.name == seller.name
            } else {
                return $0.isFavourite == true
            }
        }).sorted(by: >)
        
        return VStack(spacing: 16) {
            ForEach(nftsFiltered, id: \.identifier) { nft in
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
}
