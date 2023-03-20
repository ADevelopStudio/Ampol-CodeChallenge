//
//  ChargingCardView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import SwiftUI

struct ChargingCardView: View {
    var session: ChargingSession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 30) {
                Label(session.date, systemImage: "calendar")
                    .font(.footnote)
                Label(session.locationName, systemImage: "map")
                    .font(.footnote)
            }
            Divider()
            
            HStack(spacing: 40) {
                Label(session.kWs, systemImage: "bolt.car")
                    .font(.headline)
                    .foregroundStyle(.primary, .green)
                Label(session.time, systemImage: "clock")
                    .font(.headline)
                    .foregroundStyle(.primary, .green)
            }
            if let bonus = session.bonus {
                Label(bonus, systemImage: "gift")
                    .font(.headline)
                    .foregroundColor(.green)
            }
            
            Divider()
                .padding(.top, 10)
            Text(session.price)
                .font(.title2)
                .bold()
                .foregroundColor(.blue)
        }
    }
}

struct ChargingCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChargingCardView(session: Mock.chargingSessions.first!)
                .padding(.vertical)
                .tint(.primary)
        }
        .preferredColorScheme(.dark)
    }
}
