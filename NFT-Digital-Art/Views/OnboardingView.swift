import SwiftUI

struct OnboardingView: View {
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("image-bg")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Image("image-onboarding")
                    .resizable()
                    .scaledToFill()
                
                VStack(spacing: 0) {
                    Text("EXPLORE")
                        .font(.oswald(.medium, size: 53.sizeW))
                        .foregroundColor(.white)
                    
                    HStack(spacing: 0) {
                        Text("THE ")
                            .font(.oswald(.medium, size: 53.sizeW))
                            .foregroundColor(.white)
                        
                        Text("NFT WORLD")
                            .lineLimit(1)
                            .font(.oswald(.medium, size: 53.sizeW))
                            .foregroundColor(.custom(.purple))
                    }
                }
                .padding(.top, -38.sizeW)
                
                Button {
                    isFirstLaunch = false
                } label: {
                    Text("GET STARTED")
                        .font(.oswald(.semiBold, size: 24))
                        .foregroundColor(.custom(.black))
                        .padding(.horizontal, 36)
                        .frame(height: 60)
                        .background(
                            Color.custom(.yellow)
                                .cornerRadius(14)
                        )
                }
                .buttonStyle(ScalableButtonStyle())
                .padding(.top, 52.sizeH)
                .padding(.bottom, 44.sizeH)
            }
            .edgesIgnoringSafeArea(.top)
            .layoutPriority(-1)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingView()
            OnboardingView()
                .previewDevice("iPhone 8")
            OnboardingView()
                .previewDevice("iPod touch (7th generation)")
        }
    }
}
