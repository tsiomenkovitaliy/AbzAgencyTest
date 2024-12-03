import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab: Tab = .users
    
    var body: some View {
        VStack(spacing: 0) {
            // main content
            TabContentView(selectedTab: selectedTab)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // tab bar
            CustomTabBar(selectedTab: $selectedTab)
                .frame(height: 56)
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

#Preview {
    CustomTabView()
}
