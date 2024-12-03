import Foundation
import Network

final class NetworkManager {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    static let shared = NetworkManager()
    
    // Method check internet connection
    func isConnectedToInternet() -> Bool {
        let path = monitor.currentPath
        return path.status == .satisfied
    }
    
    // Method to start monitoring network status
    func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            NotificationCenter.default.post(name: .networkStatusChanged, object: nil, userInfo: ["isConnected": path.status == .satisfied])
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
