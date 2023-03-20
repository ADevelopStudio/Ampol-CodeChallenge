//
//  FuelCardViewModel.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import Foundation

struct FuelTransaction: Codable, Identifiable {
    var id: Int
    var locationName: String
    var locationLong: Double
    var locationLat: Double
    var fuelType: String
    private var amount: Double
    private var createdAt: Date
    private var cost: Double
    
    var invoiceURL: String = "https://slicedinvoices.com/pdf/wordpress-pdf-invoice-plugin-sample.pdf"
    
    init(id: Int, locationName: String, locationLong: Double, locationLat: Double, fuelType: String, amount: Double, createdAt: Date, cost: Double) {
        self.id = id
        self.locationName = locationName
        self.locationLong = locationLong
        self.locationLat = locationLat
        self.fuelType = fuelType
        self.amount = amount
        self.createdAt = createdAt
        self.cost = cost
    }
}



extension FuelTransaction {
    var date: String {
        Utilites.shared.humanReadableDateFormatter.string(from: createdAt)
    }
    var price: String {
        Utilites.shared.currencyFormatter.string(from:  NSNumber(floatLiteral: cost)) ?? ""
    }
    var liters: String {
        [amount.formatted(.number.precision(.fractionLength(1))), "FuelCardViewModel_liters".localised].joined(separator: " ")
    }
}
