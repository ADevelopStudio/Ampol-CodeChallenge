//
//  PretendingNetworkManager.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import Foundation

class MockedNetworkManager{
    static var stared = MockedNetworkManager()
}


extension MockedNetworkManager: NetworkService {
    func fetchDashboardDataset() async throws -> DashboardDataSet {
        Mock.dashboardDataSet
    }
    
    func fetchLastChargingSessions() async throws -> [ChargingSession] {
        try? await Task.sleep(nanoseconds: 500_000_000) //0.5 seconds
        return Mock.chargingSessions
    }
    
    func fetchLastFuelTransactions() async throws -> [FuelTransaction] {
        try? await Task.sleep(nanoseconds: 1_000_000_000) //1.0 seconds
        return Mock.fuelTransactions
    }
}
