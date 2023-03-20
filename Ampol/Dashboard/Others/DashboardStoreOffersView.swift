//
//  DashboardStoreOffersView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 20/3/2023.
//

import SwiftUI

struct DashboardStoreOffersView: View {
    var storeOffers: [StoreOffer]
    
    var body: some View {
        List(storeOffers) { offer in
            if let link = offer.url {
                Link(destination: link) {
                    HStack(spacing: 10) {
                        DashboardStoreOfferCardView(offer: offer)
                        Image(systemName: "chevron.right")
                    }
                }
            } else {
                DashboardStoreOfferCardView(offer: offer)
            }
        }
        .navigationTitle("In Store Offers")
        .navigationBarTitleDisplayMode(.inline)
    }
}
