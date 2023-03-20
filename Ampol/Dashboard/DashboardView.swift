//
//  DashboardView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import SwiftUI

struct DashboardView: View {
    @StateObject fileprivate var viewModel = DashboardViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    DashboardFuelView(fuelLoadingState: $viewModel.fuelLoadingState, fuelTransactions: $viewModel.fuelTransactions)

                    DashboardChargingView(chargingLoadingState: $viewModel.chargingLoadingState, chargingSessions: $viewModel.chargingSessions)
                    
                    DashboardOthersView(dashLoadingState: $viewModel.dashLoadingState, dataset: $viewModel.dataset)
                        .padding(.top, 10)
                    
                    Spacer()
                }
                .padding(.top, 20)
                
            }
            .refreshable {
                await viewModel.loadEverything(changeStatusToLoading: false)
            }
            .navigationTitle("\(DashboardViewStrings.gday.localised) \(User.current.name),")
        }
        .task {
            await viewModel.loadEverything()
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .preferredColorScheme(.dark)
        DashboardView()
            .preferredColorScheme(.light)
    }
}


enum DashboardViewStrings: String, CaseIterable {
    case lastFuelTransactions = "DashboardView_last_fuel_transactions" //"Your last fuel transactions:";
    case noFuelTransactionsFound = "DashboardView_No_fuel_transactions_found" //"No fuel transactions found"
    case loadingFuelTransactions = "DashboardView_Loading_your_fuel_transactions" // "Loading  your fuel transactions"
    case gday = "DashboardView_GDay" // "G'day"
    
    case lastChargingSessions = "DashboardView_last_charging_sessions" //"Recent charge session:";
    case noChargingSessionsFound = "DashboardView_No_charging_sessions_found" //"No recent chargings found"
    case loadingChargingSessions = "DashboardView_Loading_your_charging_sessions" // "Loading  your charge sessions"
}

