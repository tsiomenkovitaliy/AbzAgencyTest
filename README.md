# AbzAgencyTest

## Overview
This project is a simple iOS app designed for user sign-up functionality, including form validation, photo upload, and network monitoring. The app is built using **SwiftUI**, **Combine**, and external libraries like **Alamofire** for networking, and **NWPathMonitor** for checking internet connectivity.

## Table of Contents
- [Configuration Options](#configuration-options)
- [Dependencies](#dependencies)
- [Troubleshooting Tips](#troubleshooting-tips)
- [Build Instructions](#build-instructions)

## Configuration Options

### App Configuration
- **UserManager**: This class handles user registration and API interactions.
- **Network Monitor**: Uses `NWPathMonitor` to check for internet connectivity status.
- **Validation**: Provides methods for validating name, email, phone, and photo inputs.

### Customization
- **Validation Criteria**: You can modify the phone number validation logic (e.g., phone number prefix) by updating the regex pattern in `Validator.swift`.
- **Photo Upload Size**: The photo upload size limit can be adjusted in the `validatePhoto` method within `Validator.swift`.

## Dependencies

### Libraries Used:
1. **SwiftUI**: For building user interfaces in a declarative style.
2. **Combine**: For reactive programming to manage state and data flows in the app.
3. **Network (NWPathMonitor)**: Used for real-time network status monitoring.
4. **UIKit**: Utilized for managing image handling and user interface components.
5. **Alamofire**: Networking library used for making HTTP requests, handling responses, and managing API communication. **Alamofire** simplifies the process of making requests and parsing JSON data, ensuring the app can easily interact with backend services.

To install Alamofire, you can add it using **CocoaPods** or **Swift Package Manager**:
- **CocoaPods**:
    ```bash
    pod install
    ```
- **Swift Package Manager**:
    ```bash
    swift package update
    ```

## Troubleshooting Tips

### Network Issues:
- If the network monitor isn't reporting correctly, check the app's permissions for accessing network status.
  
### Validation Errors:
- If validation errors are not displaying, ensure the form fields are correctly bound to the `@Published` properties in the view models.

### Build Errors:
- If the build fails, make sure that all dependencies are correctly installed and there are no version conflicts, especially if using CocoaPods or Swift Package Manager.

## Build Instructions

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/project-name.git
    ```

2. Open the project in Xcode:
    - Use the `.xcworkspace` file if using CocoaPods.
    - Use the `.xcodeproj` file if managing dependencies manually.

3. Install dependencies:
    - Run the following command if using CocoaPods:
      ```bash
      pod install
      ```
    - Or run `swift build` for Swift Package Manager.

4. Build and run the app:
    - Select your target device or simulator in Xcode.
    - Press the play button (▶️) to build and run the project.

## Code Documentation

### External Libraries and APIs Used:

#### 1. **Alamofire**
   - **Why Used**: Alamofire simplifies networking tasks such as making HTTP requests, handling responses, and parsing JSON data. It allows the app to interact easily with backend services for user registration and other API calls.
   - **How It Works**: Alamofire is used for sending network requests to a server and receiving responses in a structured format. It handles tasks like JSON serialization and network request management.

#### 2. **Network (NWPathMonitor)**
   - **Why Used**: The NWPathMonitor class is part of the Network framework and is used for monitoring the network connectivity in real-time. This is crucial for notifying users if they are not connected to the internet, especially during the registration process.
   - **How It Works**: NWPathMonitor continuously monitors network status changes (e.g., Wi-Fi, cellular) and updates the UI based on connectivity.

#### 3. **Combine**
   - **Why Used**: Combine helps to manage asynchronous tasks and update the UI in a declarative way. It is used for managing form validation, network responses, and binding the UI components to the underlying data.
   - **How It Works**: Combine allows us to observe changes to form fields (name, email, etc.) and automatically update the UI based on those changes, making the app more responsive.

#### 4. **SwiftUI**
   - **Why Used**: SwiftUI is the declarative framework for building user interfaces in iOS apps. It simplifies the process of creating and maintaining UI components that react to data changes.
   - **How It Works**: SwiftUI uses data-binding properties like `@State`, `@Binding`, and `@Published` to link the UI with the underlying model. This ensures that when data changes, the UI updates automatically.

## Code Structure

The project follows a **Model-View-ViewModel (MVVM)** architecture:

### Models:
- **UserManager.swift**: Handles user registration logic and network interactions.
- **Validator.swift**: Provides validation logic for fields such as name, email, phone, and photo.
- **ValidationError.swift**: Enum defining error types related to validation issues.

### ViewModels:
- **SignUpViewModel.swift**: Manages the state of the sign-up process, including form validation and API interactions.
  
### Views:
- **SignUpView.swift**: Main view for the sign-up process, binds data to the `SignUpViewModel` and performs validation.
- **PhotoUploadView.swift**: Handles photo upload functionality.

### Utilities:
- **NetworkMonitor.swift**: A utility class that uses `NWPathMonitor` to check the network status.

By following this structure, the README and code documentation will help new developers understand the setup, customization, and dependencies used in the project, and why specific libraries and tools were chosen.

