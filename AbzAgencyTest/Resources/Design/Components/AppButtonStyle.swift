import SwiftUI

struct MainButtonStyle: ButtonStyle {
    var isDisabled: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 140 , height: 48)
            .font(AppTypography.font2())
            .background(isDisabled ? .disabledButton :
                (configuration.isPressed
                ? AppColors.pressedButton
                : AppColors.primary)
            )
            .foregroundColor(isDisabled ? AppColors.black48 : AppColors.black87)
            
            .clipShape(.capsule)
    }
}
