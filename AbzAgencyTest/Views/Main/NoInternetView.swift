import SwiftUI

struct NoInternetView: View {
    @ObservedObject var viewModel: NoInternetViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Image(.noConnect)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            // show error massage
            Text(viewModel.errorMessage)
                .font(AppTypography.heading1())
                .multilineTextAlignment(.center)
            
            Button(action: {
                viewModel.retryConnection() // reconnect to internet
            }) {
                Text("Try again")
            }
            .buttonStyle(MainButtonStyle())
        }
        .padding()
        .onAppear {
            // first check connection
            viewModel.retryConnection()
        }
    }
}

#Preview {
    NoInternetView(viewModel: NoInternetViewModel())
}
