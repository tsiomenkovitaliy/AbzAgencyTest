import SwiftUI

struct SungUpState: View {
    @Environment(\.dismiss) private var dismiss
    
    var viewModel: SignUpStateViewModel
    
    var body: some View {
        ZStack {
            Button {
                dismiss()
            } label: {
                Image(.close)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding([.trailing, .bottom], 24)

            VStack(spacing: 24) {
                Image(viewModel.isSuccess ?  .success : .error )
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                // show error massage
                Text(viewModel.message)
                    .font(AppTypography.heading1())
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    if viewModel.isSuccess {
                        dismiss()
                    } else {
                        Task {
                            await viewModel.retryRegister() // Retry user register
                        }
                    }
                    
                }) {
                    Text(viewModel.isSuccess ? "Got it" : "Try again")
                }
                .buttonStyle(MainButtonStyle())
            }
            .padding()
        }
    }
}

#Preview {
    SungUpState(viewModel: SignUpStateViewModel(isSuccess: true, message: "User successfully registered"))
}
