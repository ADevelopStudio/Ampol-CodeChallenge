//
//  HomeUsageBillsChartView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 20/3/2023.
//

import SwiftUI
import Charts

@available(iOS 16.0, *)
struct HomeUsageBillsChartView: View {
    var homeEnergyUsage: [HomeEnergyUsage]
    
    var body: some View {
        VStack {
            GroupBox {
                Chart(homeEnergyUsage) { info in
                    LineMark(
                        x: .value("Month", info.createdAt),
                        y: .value("kWs", info.kws)
                    )
                    .foregroundStyle(Color.accentColor)
                    .interpolationMethod(.catmullRom)
                    .lineStyle(StrokeStyle(lineWidth: 3))
                    .symbol() {
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 10)
                    }
                    .symbolSize(30)
                }
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .chartXAxis {
                    AxisMarks(values: .stride(by: .month)) { value in
                        AxisGridLine()
                        AxisValueLabel() {
                            if let dateValue = value.as(Date.self) {
                                Text(Utilites.shared.chartDateFormatter
                                    .string(from: dateValue))
                            }
                        }
                    }
                }
            } label: {
                Text(HomeUsageBillsChartViewStrings.chartTitle.localised)
            }
        }
        .padding(.bottom, 15)
    }
}

struct HomeUsageBillsChartView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            HomeUsageBillsChartView(homeEnergyUsage: Mock.homeEnergyUsage)
        } else {
            EmptyView()
        }
    }
}

enum HomeUsageBillsChartViewStrings: String, CaseIterable {
    case chartTitle = "HomeUsageBillsChartViewStrings_ChartTitle" //"kWs/month";
}
