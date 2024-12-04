import SwiftUI

@MainActor
final class UsersViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var hasMoreUsers = true
    
    // MARK: - Private Properties
    private var currentPage = 1
    private let pageSize = 6
    private let userManager = UserManager.shared

    // MARK: - API Methods
    // Loads users from the server asynchronously, handling pagination and updating state.
    func loadUsers() async {
        guard !isLoading, hasMoreUsers else { return } // Prevents duplicate requests.
        
        isLoading = true
        do {
            // Fetches users for the current page and updates the state.
            let userResponse = try await userManager.getUsers(page: currentPage, count: pageSize)
            users.append(contentsOf: userResponse.users)
            hasMoreUsers = userResponse.links.nextURL != nil // Checks if there are more users to load.
            currentPage += 1 // Moves to the next page.
        } catch {
            print(error.localizedDescription) // Logs errors if the request fails.
        }
        isLoading = false
    }
}
