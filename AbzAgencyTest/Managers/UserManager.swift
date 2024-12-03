import Foundation
import UIKit

final class UserManager {
    static let shared = UserManager()
    
    private let service: UserServiceProtocol

    init(service: UserServiceProtocol = UserService()) {
        self.service = service
    }
    
    // Fetches the list of positions
    func getPositions() async throws -> PositionResponse {
        try await service.fetchPositions()
    }

    // Fetches users with pagination
    func getUsers(page: Int, count: Int) async throws -> UserResponse {
        try await service.fetchUsers(page: page, count: count)
    }

    // Registers a new user
    func registerUser(request: UserRegistrationRequest) async throws -> RegisterResponse {
        let tokenResponse = try await service.fetchToken()

        return try await service.registerUser(
            request: request,
            token: tokenResponse.token
        )
    }
}
