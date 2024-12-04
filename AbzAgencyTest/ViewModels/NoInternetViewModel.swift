import Foundation
import Network

final class NoInternetViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var isConnected: Bool = true
    @Published var errorMessage: String = ""
    
    // MARK: - Private Properties
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    // MARK: - Initialization
    init() {
        startMonitoring()
    }
    // MARK: - Deinitialization
    deinit {
        stopMonitoring()
    }
    
    // MARK: - Public Methods
    
    // Start network monitoring
    func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
                if !self.isConnected {
                    self.errorMessage = "There is no internet connection"
                }
            }
        }
        monitor.start(queue: queue)
    }
    
    // Stop network monitoring
    func stopMonitoring() {
        monitor.cancel()
    }
    
    // Retry connection
    func retryConnection() {
        self.startMonitoring()
    }
}
