//
//  HomeUsageBillsView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 20/3/2023.
//

import SwiftUI

struct HomeUsageBillsView: View {
    var homeEnergyUsage: [HomeEnergyUsage]
    
    var body: some View {
        List {
            if #available(iOS 16.0, *) {
                HomeUsageBillsChartView(homeEnergyUsage:homeEnergyUsage)
            } else {
                EmptyView()
            }

            ForEach(homeEnergyUsage) { bill in
                if let url = URL(string: bill.invoiceURL) {
                    Link(destination: url) {
                        self.genarateCard(bill: bill)
                            .tint(.primary)
                    }
                } else {
                    self.genarateCard(bill: bill)
                }
            }
        }
        .padding(.top, -20)
        .navigationTitle(HomeUsageBillsViewStrings.title.localised)
        .navigationBarTitleDisplayMode(.inline)

    }
    
    private func genarateCard(bill: HomeEnergyUsage) -> some View {
        HStack(spacing: 10) {
            Image(systemName: "doc.text.image")
                .imageScale(.large)
                .font(.largeTitle)
            VStack(alignment: .leading, spacing: 5) {
                Text(bill.paidDate)
                    .font(.footnote)
                    .foregroundColor(.green)
                Text(bill.kWsUsage)
                    .bold()
            }
            Spacer()
            Text(bill.price)
                .bold()
                .foregroundColor(.blue)
        }
    }
}

enum HomeUsageBillsViewStrings: String, CaseIterable {
    case title = "HomeUsageBillsView_HomeEnergyUsage" //"Home energy usage"
}
