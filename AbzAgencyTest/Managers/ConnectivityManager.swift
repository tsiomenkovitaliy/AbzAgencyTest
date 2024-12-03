import Foundation

final class ConnectivityManager {
    
    private let networkManager = NetworkManager.shared
    
    static let shared = ConnectivityManager()
    
    private init() {}
    
    func startMonitoring() {
        networkManager.startMonitoring()
    }
    
    func stopMonitoring() {
        networkManager.stopMonitoring()
    }
    
    // check total state connection 
    func isConnected() -> Bool {
        return networkManager.isConnectedToInternet()
    }
}
