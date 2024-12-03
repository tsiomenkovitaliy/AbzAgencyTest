struct PositionResponse: Decodable {
    let success: Bool
    let positions: [Position]
}
