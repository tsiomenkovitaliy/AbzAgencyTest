import Foundation

struct Links: Decodable {
    let nextURL: String?
    let prevURL: String?

    enum CodingKeys: String, CodingKey {
        case nextURL = "next_url"
        case prevURL = "prev_url"
    }
}
