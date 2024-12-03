import UIKit
import Alamofire
import Foundation

// Defines API base URL and endpoints for the service
enum API {
    static let baseURL = "https://frontend-test-assignment-api.abz.agency/api/v1"
    
    enum Endpoint: String {
        case positions = "/positions"
        case users = "/users"
        case token = "/token"
        
        var url: String {
            return API.baseURL + self.rawValue
        }
    }
}

// Custom error type for API-related errors
enum APIError: Error {
    case custom(String)  // Specific error with a custom message
    case unknown         // Unknown error
}

// Protocol defining the user service API methods
protocol UserServiceProtocol {
    func fetchPositions() async throws -> PositionResponse
    func fetchUsers(page: Int, count: Int) async throws -> UserResponse
    func fetchToken() async throws -> TokenResponse
    func registerUser(
        request: UserRegistrationRequest,
        token: String
    ) async throws -> RegisterResponse
}

// Implementation of the user service
final class UserService: UserServiceProtocol {
    
    // Fetches available positions from the API
    func fetchPositions() async throws -> PositionResponse {
        let url = API.Endpoint.positions.url
        let response = try await AF.request(url)
            .serializingDecodable(PositionResponse.self)
            .value
        
        // Check if the response indicates success
        guard response.success else {
            throw APIError.custom("Failed to fetch positions")
        }
        
        return response
    }

    // Fetches a paginated list of users from the API
    func fetchUsers(page: Int, count: Int) async throws -> UserResponse {
        let parameters: Parameters = ["page": page, "count": count]
        return try await request(.users, parameters: parameters)
    }

    // Fetches a token from the API
    func fetchToken() async throws -> TokenResponse {
        try await request(.token)
    }

    // Registers a new user with the given request data and token
    func registerUser(
        request: UserRegistrationRequest,
        token: String
    ) async throws -> RegisterResponse {
        guard let imageData = request.photo.jpegData(compressionQuality: 0.8) else {
            throw APIError.custom("Failed to encode image.")
        }
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Token": token
        ]

        // Uploads user registration data as multipart form data
        return try await withCheckedThrowingContinuation { continuation in
            AF.upload(
                multipartFormData: { formData in
                    formData.append(Data(request.name.utf8), withName: "name")
                    formData.append(Data(request.email.utf8), withName: "email")
                    formData.append(Data(request.phone.utf8), withName: "phone")
                    formData.append(Data("\(request.positionID)".utf8), withName: "position_id")
                    formData.append(imageData, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
                },
                to: API.Endpoint.users.url,
                method: .post,
                headers: headers
            )
            .responseDecodable(of: RegisterResponse.self) { response in
                switch response.result {
                case .success(let registerResponse):
                    continuation.resume(returning: registerResponse)
                case .failure(let error):
                    let message = response.value?.message ?? error.localizedDescription
                    continuation.resume(throwing: APIError.custom(message))
                }
            }
        }
    }
    
    // Generic method to perform GET requests and decode the response
    private func request<T: Decodable>(
        _ endpoint: API.Endpoint,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil
    ) async throws -> T {
        let url = endpoint.url
        return try await AF.request(url, method: method, parameters: parameters)
            .serializingDecodable(T.self)
            .value
    }
}
