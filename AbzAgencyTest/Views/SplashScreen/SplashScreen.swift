import SwiftUI

struct SplashScreen: View {
    @Binding var isSplashScreenActive: Bool

    var body: some View {
        ZStack {
            AppColors.primary
                .ignoresSafeArea()
            Image(.logo)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // wait 1 second
                withAnimation {
                    isSplashScreenActive = false
                }
            }
        }
    }
}
