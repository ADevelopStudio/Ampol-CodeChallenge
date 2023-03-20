//
//  DashboardFuelView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 20/3/2023.
//

import SwiftUI

struct DashboardFuelView: View {
    @Binding var fuelLoadingState: LoadingState
    @Binding var fuelTransactions: [FuelTransaction]
    
    var body: some View {
        Group {
            switch fuelLoadingState {
            case .idle:
                if !fuelTransactions.isEmpty {
                    Text(DashboardViewStrings.lastFuelTransactions.localised)
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.bottom, -10)
                    FuelCarouselView(transactions: fuelTransactions)
                } else {
                    Label(DashboardViewStrings.noFuelTransactionsFound.localised, systemImage: "fuelpump")
                        .font(.headline)
                }
            case .loading:
                ProgressView(DashboardViewStrings.loadingFuelTransactions.localised)
                    .frame(maxWidth: .infinity)
            case .failed(let error):
                Label(error.localizedDescription, systemImage: "xmark.icloud")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct DashboardFuelView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardFuelView(fuelLoadingState: .constant(.idle), fuelTransactions: .constant(Mock.fuelTransactions))
    }
}
