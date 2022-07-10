import SwiftUI
import Kingfisher

struct DetailsView: View {
    let nft: Nft
    @Binding var nfts: [Nft]
    @State var showFavourites: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                ZStack {
                    Text("DETAIL")
                        .font(.oswald(.regular, size: 16))
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
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    ZStack {
                        Color.white.opacity(0.1)
                        
                        KFImage(URL(string: nft.media.first?.gateway ?? ""))
                            .resizable()
                            .scaledToFit()
                    }
                    .cornerRadius(25)
                    .clipped()
                    .padding(.top, 44)
                    .padding(.horizontal, 37)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text(nft.title ?? "No title")
                                .font(.oswald(size: 36))
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                            
                            Spacer()
                            
                            Text(String(format: "%.2f", Double(nft.title?.utf8.first ?? 0) / 10))
                                .font(.oswald(.semiBold, size: 36))
                                .foregroundColor(.yellow)
                        }
                        
                        HStack(spacing: 4) {
                            Image(nft.seller?.profileImage ?? "")
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 20, height: 20)
                            
                            Text(nft.seller?.name ?? "")
                                .font(.system(size: 12, weight: .light))
                                .foregroundColor(.white.opacity(0.6))
                            
                            Spacer()
                            
                            Text("PRICE")
                                .font(.oswald(size: 20))
                                .foregroundColor(.white.opacity(0.6))
                        }
                        
                        Text("Description")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.top, 24)
                        
                        Text(nft.description ?? "No description")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.white.opacity(0.5))
                            .lineSpacing(2)
                            .padding(.top, 12)
                    }
                    .padding(.top, 28)
                    .padding(.horizontal, 20)
                }
                
                Button {
                    showFavourites = true
                } label: {
                    Text("COMPARE")
                        .font(.oswald(.semiBold, size: 20))
                        .foregroundColor(.custom(.black))
                        .padding(.horizontal, 36)
                        .frame(height: 54)
                        .background(
                            Color.custom(.yellow)
                                .cornerRadius(14)
                        )
                }
                .buttonStyle(ScalableButtonStyle())
                .padding(.top, 36)
                .padding(.bottom, 28)
                .overlay(
                    NavigationLink(isActive: $showFavourites, destination: {
                        FilteredView(nfts: $nfts, seller: nil)
                    }, label: {
                        EmptyView()
                    })
                )
            }
        }
        .background(
            Image("image-bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .navigationBarHidden(true)
    }
}
