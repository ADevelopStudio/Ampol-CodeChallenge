//
//  DashboardUpcomingBillView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 20/3/2023.
//

import SwiftUI

struct DashboardUpcomingBillView: View {
    var upcomingEnergyBill: UpcomingEnergyBill

    var body: some View {
        Group {
            Label("Upcoming enegry bill", systemImage: "info.circle")
                .font(.headline)
                .padding(.bottom, -10)
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    Label(upcomingEnergyBill.payByDate, systemImage: "calendar")
                        .foregroundStyle(.primary, .green)
                        .font(.headline)
                    Label(upcomingEnergyBill.kWsUsage, systemImage: "bolt.circle")
                        .foregroundStyle(.primary, .green)
                        .font(.headline)
                    Text(upcomingEnergyBill.price)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.blue)
                }
                Spacer()
            }
            .asCard()
        }
    }
}
