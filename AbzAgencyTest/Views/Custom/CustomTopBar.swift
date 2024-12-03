import SwiftUI

enum MethodType: String {
    case get = "GET"
    case post = "POST"
}

struct CustomTopBar: View {
    var method = MethodType.get
    
    var body: some View {
        Text("Working with \(method.rawValue) request")
            .foregroundStyle(AppColors.onSurface)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(AppColors.primary)
            .padding(.top, 1)
    }
}

#Preview {
    CustomTopBar()
}
