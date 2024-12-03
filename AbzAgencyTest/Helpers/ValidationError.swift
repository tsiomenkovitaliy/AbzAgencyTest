import Foundation

enum ValidationError: LocalizedError {
    case name(String)
    case email(String)
    case phone(String)
    case photo(String)

    var errorDescription: String? {
        switch self {
        case .name(let message), .email(let message), .phone(let message), .photo(let message):
            return message
        }
    }
}
