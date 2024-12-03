import SwiftUI

struct PhotoUploadView: View {
    @Binding var isPhotoUploaded: Bool
    @Binding var showActionSheet: Bool
    @Binding var errorMessage: String
    @Binding var imageName: String?
    
    var placeholder = "Upload your photo"
    var dismissKeyboard: (() -> Void)?
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text((imageName?.isEmpty ?? true) ? placeholder : imageName ?? placeholder)
                    .lineLimit(1)
                    .font(AppTypography.body2())
                    .foregroundColor(!errorMessage.isEmpty ? AppColors.error : AppColors.black48)
                
                Spacer()
                
                Button(action: {
                    showActionSheet = true
                    dismissKeyboard?()
                }) {
                    Text("Upload")
                        .font(AppTypography.body2())
                        .foregroundColor(AppColors.secondary)
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(!errorMessage.isEmpty ? AppColors.error : AppColors.borderColor, lineWidth: 1)
            )
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(AppTypography.body2())
                    .foregroundColor(AppColors.error)
                    .padding(.horizontal)
            }
        }
        .padding(.horizontal)
        .frame(height: 76)
    }
}

#Preview {
    PhotoUploadView(isPhotoUploaded: .constant(true), showActionSheet: .constant(false), errorMessage: .constant("Error"), imageName: .constant("ImageName")) {
    }
}
