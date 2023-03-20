//
//  ConnectionManager.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import Foundation


class ConnectionManager {
    
#if DEBUG
    static let shared = MockedNetworkManager()
#else
    static let shared = ConnectionManager()
#endif
    
    
    private func fetch<T: Decodable>(url: URL?) async throws -> T {
        guard let url else { throw ServiceError.invalidUrl }
        var urlRequest =  URLRequest(url: url)
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return try Utilites.shared.decoder.decode(T.self, from: data)
    }
    
    fileprivate func fetch<T: Decodable>(apiPath: ApiPath) async throws -> T {
        try await self.fetch(url: apiPath.url)
    }
}


extension ConnectionManager: NetworkService {
    func fetchDashboardDataset() async throws -> DashboardDataSet {
        try await self.fetch(apiPath: .getDashboardDetails)
    }
    
    func fetchLastChargingSessions() async throws -> [ChargingSession] {
        try await self.fetch(apiPath: .getChargingSessions)
    }
    
    func fetchLastFuelTransactions() async throws -> [FuelTransaction] {
        try await self.fetch(apiPath: .getFuelTransactions)
    }
}

