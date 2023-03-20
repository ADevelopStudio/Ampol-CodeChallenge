//
//  ChargingSessionsView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 20/3/2023.
//

import SwiftUI

struct ChargingSessionsView: View {
    var sessions: [ChargingSession]
    
    var body: some View {
        List(sessions) { session in
            NavigationLink {
                ChargingSingleTransactionView(session: session)
            } label: {
                HStack {
                    Text(session.date)
                        .font(.subheadline)
                    Spacer()
                    Text(session.price)
                        .font(.footnote)
                        .foregroundColor(.accentColor)
                }
            }
        }
        .padding(.top, -30)
        .navigationTitle(ChargingSessionsViewStrings.title.localised)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChargingSessionsView_Previews: PreviewProvider {
    static var previews: some View {
        ChargingSessionsView(sessions: Mock.chargingSessions)
            .preferredColorScheme(.dark)
    }
}

enum ChargingSessionsViewStrings: String, CaseIterable {
    case title = "ChargingSessionsView_Title" //"Charging sessions";
}
