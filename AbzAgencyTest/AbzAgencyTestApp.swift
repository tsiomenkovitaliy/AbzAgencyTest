import SwiftUI

@main
struct AbzAgencyTestApp: App {
    @StateObject private var signUpViewModel = SignUpViewModel()
    @StateObject private var usersViewModel = UsersViewModel()
    
    @State private var isSplashScreenActive = true
    
    var body: some Scene {
        WindowGroup {
            if isSplashScreenActive {
                SplashScreen(isSplashScreenActive: $isSplashScreenActive)
            } else {
                MainTabBarView()
                    .environmentObject(signUpViewModel)
                    .environmentObject(usersViewModel)
                    .preferredColorScheme(.light)
            }
        }
    }
}
