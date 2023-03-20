//
//  FailedNetworkService.swift
//  AmpolTests
//
//  Created by Dmitrii Zverev on 20/3/2023.
//

import Foundation
@testable import Ampol

class FailedNetworkService {
    private(set) var error: Error
    
    init(error: Error) {
        self.error = error
    }
    
    fileprivate func fetch<T: Decodable>(apiPath: ApiPath) async throws -> T {
        throw error
    }
}


extension FailedNetworkService: NetworkService {
    func fetchLastFuelTransactions() async throws -> [Ampol.FuelTransaction] {
        try await self.fetch(apiPath: .getFuelTransactions)
    }
    
    func fetchLastChargingSessions() async throws -> [Ampol.ChargingSession] {
        try await self.fetch(apiPath: .getChargingSessions)
    }
    
    func fetchDashboardDataset() async throws -> Ampol.DashboardDataSet {
        try await self.fetch(apiPath: .getDashboardDetails)
    }
}
