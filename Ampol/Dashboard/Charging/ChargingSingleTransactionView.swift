//
//  ChargingSingleTransactionView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 20/3/2023.
//

import SwiftUI
import MapKit


extension ChargingSession {
    var region: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.locationLat, longitude: self.locationLong), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
    var poi: PointOfInterest {
        PointOfInterest(latitude: self.locationLat, longitude: self.locationLong)
    }
}

struct ChargingSingleTransactionView: View {
    var session: ChargingSession
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Map(coordinateRegion: .constant(self.session.region), annotationItems: [session.poi]) { ann in
                        MapMarker(coordinate: ann.coordinates, tint: .accentColor)
                    }
                    .frame(height: Utilites.screenWidth)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    HStack {
                        Label(session.date, systemImage: "calendar")
                            .font(.footnote)
                        Spacer()
                        Label(session.locationName, systemImage: "map")
                            .font(.footnote)
                    }
                    .padding(.bottom, 20)
                    
                    Label(session.kWs, systemImage: "bolt.car")
                        .font(.title3)
                        .foregroundStyle(.primary, .green)
                    Label(session.time, systemImage: "clock")
                        .font(.title3)
                        .foregroundStyle(.primary, .green)
                    
                    if let bonus = session.bonus {
                        Label(bonus, systemImage: "gift")
                            .font(.title3)
                            .foregroundColor(.blue)
                    }
                    Divider()
                    Text(session.price)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.accentColor)
                }
                .frame(maxHeight: .infinity)
            }
            Spacer()
            if let url = URL(string: session.invoiceURL) {
                Link(FuelSingleTransactionViewStrings.downloadInvoice.localised, destination: url)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.accentColor, lineWidth: 2)
                    }
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChargingSingleTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        ChargingSingleTransactionView(session: Mock.chargingSessions.first!)
            .preferredColorScheme(.dark)
    }
}
