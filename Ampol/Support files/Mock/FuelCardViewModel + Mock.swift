//
//  FuelCardViewModel + Mock.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import Foundation

struct Mock {
    static var fuelTransactions: [FuelTransaction] {
        (0..<10).map {
            let liters =  Double.random(in: 10...100)
            return FuelTransaction(id: $0,
                                   locationName: "Sydney CBD, 2000",
                                   locationLong: 151.2093,
                                   locationLat: -33.8688,
                                   fuelType: "E98",
                                   amount: liters,
                                   createdAt: .now.addingTimeInterval(-24*60*60*Double($0) - Double.random(in: 60...10_000)),
                                   cost: liters * Double.random(in: 1.45...2.5))
        }
    }
    
    static var chargingSessions: [ChargingSession] {
        (0..<10).map {
            let amount =  Double.random(in: 10...100)
            let discounts: Array<String?> =  ["NRMA 15%", "QANTAS 20%", nil]
            return ChargingSession(id: $0,
                                   locationName: "Sydney CBD, 2000",
                                   locationLong: 151.2093,
                                   locationLat: -33.8688,
                                   discount: discounts.randomElement() ?? nil,
                                   chargingTime: Int.random(in: 10...60),
                                   amount: amount,
                                   createdAt: .now.addingTimeInterval(-24*60*60*Double($0) - Double.random(in: 60...10_000)),
                                   cost: amount * Double.random(in: 0.35...0.65))
        }
    }
    
    
    
    static var storeOffers: [StoreOffer] {
        [
            StoreOffer(title: "In store special", details: "Any two Cadbury medium bars 39-60g for $4.50"),
            StoreOffer(title: "Win", details: "Buy any 2 of the Gatorade 600mL range for $7 and go into the draw to win."),
            StoreOffer(title: "Special price", details: "Purchase any 2 of the V Energy 250ml range for $5.50")
        ]
    }
    
    static var dashboardDataSet: DashboardDataSet {
        DashboardDataSet(storeOffers: storeOffers, upcomingEnergyBill: upcomingEnergyBill, homeEnergyUsage: homeEnergyUsage)
    }
    
    
    static var upcomingEnergyBill: UpcomingEnergyBill {
        UpcomingEnergyBill(kws: Double.random(in: 100...200), dueDate: .now.addingTimeInterval(6*24*60*60))
    }
    
    
    static var homeEnergyUsage: [HomeEnergyUsage] {
        (1...10).map { number in
            HomeEnergyUsage(kws: Double.random(in: 1...5), createdAt: .now.addingTimeInterval(Double(-number)*30*24*60*60))
        }
    }
}

