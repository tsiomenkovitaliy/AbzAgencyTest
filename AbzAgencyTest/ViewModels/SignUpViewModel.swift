import SwiftUI
import Combine

@MainActor
final class SignUpViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    
    @Published var isPhotoUploaded: Bool = false
    @Published var photoName: String? = ""
    
    // Validation errors for form fields
    @Published var nameError: String = ""
    @Published var emailError: String = ""
    @Published var phoneError: String = ""
    @Published var photoError: String = ""
    
    @Published var selectedPosition: Position?
    @Published var positions: [Position] = []
    
    @Published var isLoading: Bool = false // Tracks loading state during API calls
    @Published var message: String = "" // Message to display to the user
    @Published var isSignUpEnabled: Bool = false // Indicates if the sign-up button should be enabled
    @Published var isSuccess: Bool = false // Indicates if the sign-up was successful
    @Published var isShowStateView: Bool = false
    @Published var userRequest: UserRegistrationRequest?
    
    @Published var photo: UIImage? { didSet { validatePhoto() } }
    
    
    // MARK: - Private Properties
    private let userManager = UserManager.shared // Shared instance of UserManager
    
    // MARK: - Initialization
    init() {
        setupBindings() // Setup reactive bindings for form validation
        Task { [weak self] in
            await self?.getPositions() // Fetch available positions on initialization
        }
    }
    
    // MARK: - Private Methods
    /// Sets up reactive bindings to validate form fields and enable sign-up
    private func setupBindings() {
        let validationErrors = Publishers.CombineLatest4($nameError, $emailError, $phoneError, $photoError)
        let formFields = Publishers.CombineLatest4($name, $email, $phone, $photo)
        
        validationErrors
            .combineLatest(formFields, $isLoading)
            .map { validationErrors, formFields, isLoading in
                let (nameError, emailError, phoneError, photoError) = validationErrors
                let (name, email, phone, photo) = formFields
                
                return !isLoading &&
                       nameError.isEmpty &&
                       emailError.isEmpty &&
                       phoneError.isEmpty &&
                       photoError.isEmpty &&
                       !name.isEmpty &&
                       !email.isEmpty &&
                       !phone.isEmpty &&
                       photo != nil
            }
            .assign(to: &$isSignUpEnabled)
    }
    
    // MARK: - Validation Methods
    /// Validates the name field
    func validateName() {
        let result = Validator.validateName(name)
        switch result {
        case .success:
            nameError = ""
        case .failure(let error):
            nameError = error.localizedDescription
        }
    }

    /// Validates the phone field
    func validatePhone() {
        let result = Validator.validatePhoneNumber(phone)
        switch result {
        case .success:
            phoneError = ""
        case .failure(let error):
            phoneError = error.localizedDescription
        }
    }

    /// Validates the email field
    func validateEmail() {
        let result = Validator.validateEmail(email)
        switch result {
        case .success:
            emailError = ""
        case .failure(let error):
            emailError = error.localizedDescription
        }
    }

    /// Validates the photo field
    func validatePhoto() {
        let result = Validator.validatePhoto(photo)
        switch result {
        case .success:
            photoError = ""
        case .failure(let error):
            photoError = error.localizedDescription
        }
    }

    // MARK: - API Methods
    /// Fetches positions from the server
    private func getPositions() async {
        do {
            let response = try await userManager.getPositions()
            positions = response.positions
            selectedPosition = positions.first
        } catch {
            print("Failed to fetch positions: \(error)")
        }
    }
    
    /// Registers the user with the provided details
    func registerUser() async {
        guard let selectedPosition, let photo = photo else {
            message = "Fields are required"
            return
        }
        
        isLoading = true
        
        userRequest = UserRegistrationRequest(
            name: name,
            email: email,
            phone: phone,
            positionID: selectedPosition.id,
            photo: photo
        )
        
        do {
            let response = try await userManager.registerUser(request: userRequest!)
            isSuccess = response.success
            message = response.message
        } catch {
            message = error.localizedDescription
        }
        
        isShowStateView = true
        isLoading = false
    }
}
