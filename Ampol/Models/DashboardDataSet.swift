//
//  DashboardDataSet.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 20/3/2023.
//

import Foundation

struct DashboardDataSet: Codable {
    var storeOffers: [StoreOffer]
    var upcomingEnergyBill: UpcomingEnergyBill?
    var homeEnergyUsage: [HomeEnergyUsage]
}

struct StoreOffer: Codable, Identifiable {
    var id = UUID()
    var title: String
    var details: String
    private var link: String = "https://www.ampol.com.au/convenience/discounts-and-rewards"
    
    var url: URL? {
        URL(string: link)
    }
    
    init(title: String, details: String) {
        self.title = title
        self.details = details
    }
}

struct UpcomingEnergyBill: Codable {
    var id = UUID()
    private var kws: Double //kws
    private var dueDate: Date
    
    init(kws: Double, dueDate: Date) {
        self.kws = kws
        self.dueDate = dueDate
    }
    var payByDate: String {
        ["Pay by", Utilites.shared.humanReadableDateFormatterWithotTime.string(from: dueDate)].joined(separator: ": ")
    }
    
    var price: String {
        Utilites.shared.currencyFormatter.string(from:  NSNumber(floatLiteral: kws * User.current.homeUsageCoastPerKW)) ?? ""
    }
    var kWsUsage: String {
        [kws.formatted(.number.precision(.fractionLength(1))), ChargingSessionStrings.kws.localised].joined(separator: " ")
    }
}

struct HomeEnergyUsage: Codable, Identifiable {
    var id = UUID()
    private var kws: Double
    private var createdAt: Date
    
    init(kws: Double, createdAt: Date) {
        self.kws = kws
        self.createdAt = createdAt
    }
    
    var paidDate: String {
        ["Paid", Utilites.shared.humanReadableDateFormatterWithotTime.string(from: createdAt)].joined(separator: ": ")
    }
    
    var price: String {
        Utilites.shared.currencyFormatter.string(from:  NSNumber(floatLiteral: kws * User.current.homeUsageCoastPerKW)) ?? ""
    }
    var kWsUsage: String {
        [kws.formatted(.number.precision(.fractionLength(1))), ChargingSessionStrings.kws.localised].joined(separator: " ")
    }
}
