import SwiftUI

@main
struct NFTDigitalArtApp: App {
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                OnboardingView()
            } else {
                DashboardView()
            }
        }
    }
}
