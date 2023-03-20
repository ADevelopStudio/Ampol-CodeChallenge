//
//  DashboardViewModel.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import SwiftUI

@MainActor
class DashboardViewModel: ObservableObject {
    @Published var fuelLoadingState: LoadingState = .loading
    @Published var fuelTransactions: [FuelTransaction] = []
    @Published var chargingLoadingState: LoadingState = .loading
    @Published var chargingSessions: [ChargingSession] = []
    @Published var dashLoadingState: LoadingState = .loading
    @Published var dataset: DashboardDataSet?
    
    private let network: NetworkService
    
    init(network: NetworkService = MockedNetworkManager.stared) {
        self.network = network
    }
    
    func loadEverything(changeStatusToLoading: Bool = true) async {
        await self.loadFuelTransactions(changeStatusToLoading)
        await self.loadChargingSessions(changeStatusToLoading)
        await self.loadDashData(changeStatusToLoading)
    }
    
    private func loadFuelTransactions(_ changeStatusToLoading: Bool) async {
        if changeStatusToLoading {
            self.fuelLoadingState = .loading
        }
        do {
            let result = try await network.fetchLastFuelTransactions()
            withAnimation {
                self.fuelTransactions = result
                self.fuelLoadingState = .idle
            }
        } catch {
            withAnimation {
                self.fuelLoadingState = .failed(error)
            }
        }
    }
    
    private func loadChargingSessions(_ changeStatusToLoading: Bool) async {
        if changeStatusToLoading {
            self.chargingLoadingState = .loading
        }
        do {
            let result = try await network.fetchLastChargingSessions()
            withAnimation {
                self.chargingSessions = result
                self.chargingLoadingState = .idle
            }
        } catch {
            withAnimation {
                self.chargingLoadingState = .failed(error)
            }
        }
    }
    
    private func loadDashData(_ changeStatusToLoading: Bool) async {
        if changeStatusToLoading {
            self.dashLoadingState = .loading
        }
        do {
            let result = try await network.fetchDashboardDataset()
            withAnimation {
                self.dataset = result
                self.dashLoadingState = .idle
            }
        } catch {
            withAnimation {
                self.dashLoadingState = .failed(error)
            }
        }
    }
}
