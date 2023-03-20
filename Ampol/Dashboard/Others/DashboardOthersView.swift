//
//  DashboardOthersView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 20/3/2023.
//

import SwiftUI

struct DashboardOthersView: View {
    @Binding var dashLoadingState: LoadingState
    @Binding var dataset: DashboardDataSet?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            switch dashLoadingState {
            case .idle:
                if let upcomingEnergyBill = dataset?.upcomingEnergyBill {
                    DashboardUpcomingBillView(upcomingEnergyBill: upcomingEnergyBill)
                }
                
                if let _ = dataset?.homeEnergyUsage.first {
                    HStack {
                        Label("Home energy usage history", systemImage: "chart.xyaxis.line")
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                    }
                    .font(.headline)
                    .foregroundColor(.accentColor)
                    .asCard()
                }
                
                if let firstOffer = dataset?.storeOffers.first {
                    HStack {
                        Label("In Store Offers", systemImage: "bell.badge")
                            .font(.headline)

                        Spacer()
                        NavigationLink {
                            DashboardStoreOffersView(storeOffers: dataset?.storeOffers ?? [])
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
                    .padding(.bottom, -10)
                    .padding(.top)
                    
                    DashboardStoreOfferView(offer: firstOffer)
                }
                
                Spacer()
            case .loading:
                ProgressView()
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

struct DashboardOthersView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardOthersView(dashLoadingState: .constant(.idle), dataset: .constant(Mock.dashboardDataSet))
    }
}
