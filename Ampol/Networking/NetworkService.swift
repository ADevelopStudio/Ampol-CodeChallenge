//
//  NetworkService.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import Foundation

protocol NetworkService {
    func fetchLastFuelTransactions() async throws -> [FuelTransaction]
    func fetchLastChargingSessions() async throws -> [ChargingSession]
    func fetchDashboardDataset() async throws -> DashboardDataSet
}



