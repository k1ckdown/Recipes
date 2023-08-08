//
//  NetworkMonitor.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue.global()
    
    private(set) var isConnected = false
    
    private init() {
        monitor = .init()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
