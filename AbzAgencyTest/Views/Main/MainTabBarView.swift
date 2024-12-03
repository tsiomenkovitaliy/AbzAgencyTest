import SwiftUI

struct MainTabBarView: View {
    @StateObject private var noInternetViewModel = NoInternetViewModel()
    
    var body: some View {
        VStack {
            // Show the error screen if there is no internet connection
            if !noInternetViewModel.isConnected {
                NoInternetView(viewModel: noInternetViewModel)
            } else {
                CustomTabView()
            }
        }
        .onAppear {
            // Start monitoring internet connection
            noInternetViewModel.startMonitoring()
        }
        .onDisappear {
            // Stop monitoring when the view disappears
            noInternetViewModel.stopMonitoring()
        }
    }
}

#Preview {
    MainTabBarView()
}
