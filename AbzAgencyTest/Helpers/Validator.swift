import UIKit

final class Validator {
    /// Stores regex patterns used for validation
    private enum RegexPatterns {
        static let phone = "^\\+380[0-9]{9}$" // Regex for validating Ukrainian phone numbers
        static let email = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$" // Regex for validating email format
    }
    
    /// Validates the phone number format
    /// - Parameter phoneNumber: The phone number string to validate
    /// - Returns: ValidationResult indicating success or specific failure reason
    static func validatePhoneNumber(_ phoneNumber: String) -> ValidationResult {
        guard !phoneNumber.isEmpty else {
            return .failure(.phone("Required field"))
        }

        guard phoneNumber.hasPrefix("+380") else {
            return .failure(.phone("Phone number must start with +380"))
        }

        let phoneRegex = RegexPatterns.phone
        let isValid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phoneNumber)

        guard isValid else {
            return .failure(.phone("Invalid phone format"))
        }

        return .success
    }

    /// Validates the email format
    /// - Parameter email: The email string to validate
    /// - Returns: ValidationResult indicating success or specific failure reason
    static func validateEmail(_ email: String) -> ValidationResult {
        guard !email.isEmpty else {
            return .failure(.email("Required field"))
        }

        let emailRegex = RegexPatterns.email
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        guard predicate.evaluate(with: email) else {
            return .failure(.email("Invalid email format"))
        }

        return .success
    }

    /// Validates the user's name
    /// - Parameter name: The name string to validate
    /// - Returns: ValidationResult indicating success or specific failure reason
    static func validateName(_ name: String) -> ValidationResult {
        guard !name.isEmpty else {
            return .failure(.name("Required field"))
        }

        guard name.count >= 2 && name.count <= 60 else {
            return .failure(.name("Name should be 2-60 characters"))
        }

        return .success
    }

    /// Validates the user's photo
    /// - Parameter photo: The photo as a UIImage to validate
    /// - Returns: ValidationResult indicating success or specific failure reason
    static func validatePhoto(_ photo: UIImage?) -> ValidationResult {
        guard let photo else {
            return .failure(.photo("Photo is required"))
        }

        guard let imageData = photo.jpegData(compressionQuality: 1.0),
              imageData.count <= 5 * 1024 * 1024 else {
            return .failure(.photo("Photo size must not exceed 5MB"))
        }

        let width = photo.size.width
        let height = photo.size.height
        guard width >= 70, height >= 70 else {
            return .failure(.photo("Photo resolution must be at least 70x70px"))
        }

        return .success
    }
}
