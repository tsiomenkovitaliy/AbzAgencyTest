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
    git clone https://github.com/tsiomenkovitaliy/AbzAgencyTest.git
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
