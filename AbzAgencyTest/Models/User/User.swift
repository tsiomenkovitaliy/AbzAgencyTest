import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let position: String
    let positionID: Int
    let registrationTimestamp: Int
    let photo: String

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, position, photo
        case positionID = "position_id"
        case registrationTimestamp = "registration_timestamp"
    }
}
