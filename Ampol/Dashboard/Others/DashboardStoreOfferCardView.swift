//
//  DashboardStoreOfferCardView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 20/3/2023.
//

import SwiftUI

struct DashboardStoreOfferView: View {
    var offer: StoreOffer

    var body: some View {
        Group {
            HStack {
                if let link = offer.url {
                    Link(destination: link) {
                        HStack(spacing: 10) {
                            DashboardStoreOfferCardView(offer: offer)
                            Image(systemName: "chevron.right")
                        }
                    }
                    .padding(.horizontal, -16)
                    .asCard()
                } else {
                    DashboardStoreOfferCardView(offer: offer)
                        .asCard()
                }
            }
        }
    }
}


struct DashboardStoreOfferCardView: View {
    var offer: StoreOffer

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(offer.title)
                .font(.title2)
                .bold()
                .foregroundColor(.blue)
            Text(offer.details)
                .font(.callout)
                .foregroundColor(.primary)
        }
    }
}
