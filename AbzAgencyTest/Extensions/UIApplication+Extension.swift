import SwiftUI

extension UIApplication {
    var safeAreaInsets: UIEdgeInsets {
        let keyWindow = connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        
        return keyWindow?.safeAreaInsets ?? .zero
    }
}
