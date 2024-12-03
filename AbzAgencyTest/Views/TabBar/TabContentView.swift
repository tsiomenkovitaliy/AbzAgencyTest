import SwiftUI

struct TabContentView: View {
    let selectedTab: Tab
    
    var body: some View {
        switch selectedTab {
        case .users:
            UserListView()
        case .singUp:
            SignUpView()
        }
    }
}
