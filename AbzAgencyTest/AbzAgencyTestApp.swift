import SwiftUI

@main
struct AbzAgencyTestApp: App {
    @State private var isSplashScreenActive = true
    
    var body: some Scene {
        WindowGroup {
            if isSplashScreenActive {
                SplashScreen(isSplashScreenActive: $isSplashScreenActive)
            } else {
                MainTabBarView()
                    .preferredColorScheme(.light)
            }
        }
    }
}
