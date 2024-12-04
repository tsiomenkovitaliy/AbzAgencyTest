import SwiftUI

final class SignUpStateViewModel {
    // MARK: - Published Properties
    @Published var userRequest: UserRegistrationRequest?
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool
    @Published var message: String
    
    // MARK: - Private Properties
    private var userManager = UserManager.shared
    
    // MARK: - Initializer
    init(userRequest: UserRegistrationRequest? = nil, isSuccess: Bool, message: String) {
        self.message = message
        self.userRequest = userRequest
        self.isSuccess = isSuccess
    }
    
    // MARK: - Public Methods
    func retryRegister() async {
        isLoading = true
        
        guard let userRequest else { return }
        
        do {
            let response = try await userManager.registerUser(request: userRequest)
            isSuccess = response.success
            message = response.message
        } catch {
            message = error.localizedDescription
        }
        
        isLoading = false
    }
}
