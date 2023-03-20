//
//  FuelCardView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import SwiftUI
struct FuelCardView: View {
    var transaction: FuelTransaction
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(transaction.date, systemImage: "calendar")
                .font(.footnote)
            Label(transaction.locationName, systemImage: "map")
                .font(.footnote)
            Divider()
            Label(transaction.fuelType, systemImage: "fuelpump")
                .font(.headline)
                .foregroundStyle(.primary, .green)
            Label(transaction.liters, systemImage: "speedometer")
                .font(.headline)
                .foregroundStyle(.primary, .green)
            Spacer()
            Divider()
            Text(transaction.price)
                .font(.title2)
                .bold()
                .foregroundColor(.blue)
        }
    }
}

struct FuelCardView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            FuelCardView(transaction: Mock.fuelTransactions.first!)
                .padding(.vertical)
                .tint(.primary)
        }
        .preferredColorScheme(.dark)
    }
}
