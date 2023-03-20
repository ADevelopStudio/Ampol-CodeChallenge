//
//  ChargingTransaction.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 20/3/2023.
//

import Foundation
struct ChargingSession: Codable, Identifiable {
    var id: Int
    var locationName: String
    var locationLong: Double
    var locationLat: Double
    private var discount: String?
    private var chargingTime: Int
    private var amount: Double
    private var createdAt: Date
    private var cost: Double
    

    var invoiceURL: String = "https://slicedinvoices.com/pdf/wordpress-pdf-invoice-plugin-sample.pdf"
    
    init(id: Int, locationName: String, locationLong: Double, locationLat: Double, discount: String?, chargingTime: Int, amount: Double, createdAt: Date, cost: Double) {
        self.id = id
        self.locationName = locationName
        self.locationLong = locationLong
        self.locationLat = locationLat
        self.discount = discount
        self.chargingTime = chargingTime
        self.amount = amount
        self.createdAt = createdAt
        self.cost = cost
    }
}



extension ChargingSession {
    var bonus: String? {
        guard let discount else { return nil }
        return [ChargingSessionStrings.bonus.localised , discount].joined(separator: ": ")
    }
    
    var time: String {
        [String(chargingTime), ChargingSessionStrings.minutes.localised].joined(separator: " ")
    }
    
    var date: String {
        Utilites.shared.humanReadableDateFormatter.string(from: createdAt)
    }
    var price: String {
        Utilites.shared.currencyFormatter.string(from:  NSNumber(floatLiteral: cost)) ?? ""
    }
    var kWs: String {
        [amount.formatted(.number.precision(.fractionLength(1))), ChargingSessionStrings.kws.localised].joined(separator: " ")
    }
}

enum ChargingSessionStrings: String, CaseIterable {
    case bonus = "ChargingSession_Bonus" //"Bonus";
    case minutes = "ChargingSession_Minutes" //"mins";
    case kws = "ChargingSession_kWs" //"kWs";
}
