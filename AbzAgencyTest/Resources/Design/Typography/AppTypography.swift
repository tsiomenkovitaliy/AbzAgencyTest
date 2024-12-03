import SwiftUI

enum FontWight: String {
    case regular    = "Regular"
    case bold       = "Bold"
}

struct AppTypography {
    private static let fontName: String = "NunitoSans"
    
    struct FontSize {
        static let heading1: CGFloat = 20
        static let body1: CGFloat = 16
        static let body2: CGFloat = 18
        static let body3: CGFloat = 14
    }
    
    static func font2() -> Font {
        Font.custom("\(fontName)-\(FontWight.bold.rawValue)", size: FontSize.body2)
    }
    
    static func heading1() -> Font {
        Font.custom("\(fontName)-\(FontWight.regular.rawValue)", size: FontSize.heading1)
    }
    
    static func body1(wight: FontWight = .regular) -> Font {
        Font.custom("\(fontName)-\(wight.rawValue)", size: FontSize.body1)
    }
    
    static func body2() -> Font {
        Font.custom("\(fontName)-\(FontWight.regular.rawValue)", size: FontSize.body2)
    }
    
    static func body3() -> Font {
        Font.custom("\(fontName)-\(FontWight.regular.rawValue)", size: FontSize.body3)
    }
}
