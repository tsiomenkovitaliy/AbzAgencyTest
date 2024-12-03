struct RegisterResponse: Decodable {
    let success: Bool
    let userId: Int?
    let message: String
}
