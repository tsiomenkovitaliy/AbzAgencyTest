import Foundation

final class ConnectivityManager {
    // MARK: - Properties
    
    /// Singleton instance
    static let shared = ConnectivityManager()
    
    /// Private network manager instance
    private let networkManager = NetworkManager.shared
    
    // MARK: - Initialization
    
    /// Private initializer to enforce singleton usage
    private init() {}
    
    // MARK: - Public Methods
    
    /// Starts monitoring the network connection.
    func startMonitoring() {
        networkManager.startMonitoring()
    }
    
    /// Stops monitoring the network connection.
    func stopMonitoring() {
        networkManager.stopMonitoring()
    }
    
    /// Checks if the device is connected to the internet.
    /// - Returns: `true` if connected, `false` otherwise.
    func isConnected() -> Bool {
        return networkManager.isConnectedToInternet()
    }
}
