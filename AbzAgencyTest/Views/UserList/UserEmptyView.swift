import SwiftUI

struct UserEmptyView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(.emptyUserList)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text("There are no users yet")
                .font(AppTypography.heading1())
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    UserEmptyView()
}
