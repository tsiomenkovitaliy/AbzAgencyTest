enum Tab: String, CaseIterable {
    case users
    case singUp
    
    var title: String {
        switch self {
        case .users: return "Users"
        case .singUp: return "Sing Up"
        }
    }
    
    var iconName: String {
        switch self {
        case .users: return "users"
        case .singUp: return "singup"
        }
    }
}
