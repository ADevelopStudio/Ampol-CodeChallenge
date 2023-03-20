//
//  DashboardChargingView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 20/3/2023.
//

import SwiftUI

struct DashboardChargingView: View {
    @Binding var chargingLoadingState: LoadingState
    @Binding var chargingSessions: [ChargingSession]
    
    var body: some View {
        Group {
            switch chargingLoadingState {
            case .idle:
                if let lastSession = chargingSessions.first {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(DashboardViewStrings.lastChargingSessions.localised)
                                .font(.headline)
                            Spacer()
                            NavigationLink {
                                ChargingSessionsView(sessions: chargingSessions)
                            } label: {
                                Group {
                                    Text(FuelCarouselViewStrings.seeAll.localised)
                                        .font(.headline)
                                        .foregroundColor(.accentColor)
                                    Image(systemName: "chevron.right")
                                        .imageScale(.small)
                                        .font(.headline)
                                        .foregroundColor(.accentColor)
                                }
                                .tint(.primary)
                            }
                        }
                    }
                    
                    NavigationLink {
                        ChargingSingleTransactionView(session: lastSession)
                    } label: {
                        ChargingCardView(session: lastSession)
                            .asCard()
                            .tint(.primary)
                    }
                    
                } else {
                    Label(DashboardViewStrings.noChargingSessionsFound.localised, systemImage: "bolt.car")
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
        .padding(.horizontal)
    }
}

struct DashboardChargingView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DashboardChargingView(chargingLoadingState: .constant(.idle), chargingSessions: .constant(Mock.chargingSessions))
            Spacer()
        }
        .preferredColorScheme(.dark)
    }
}
