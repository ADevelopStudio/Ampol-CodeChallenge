//
//  FuelSingleTransactionView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import SwiftUI
import MapKit

extension FuelTransaction {
    var region: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.locationLat, longitude: self.locationLong), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
    var poi: PointOfInterest {
        PointOfInterest(latitude: self.locationLat, longitude: self.locationLong)
    }
}

struct FuelSingleTransactionView: View {
    var transaction: FuelTransaction
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Map(coordinateRegion: .constant(self.transaction.region), annotationItems: [transaction.poi]) { ann in
                        MapMarker(coordinate: ann.coordinates, tint: .accentColor)
                    }
                    .frame(height: Utilites.screenWidth)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    HStack {
                        Label(transaction.date, systemImage: "calendar")
                            .font(.footnote)
                        Spacer()
                        Label(transaction.locationName, systemImage: "map")
                            .font(.footnote)
                    }
                    .padding(.bottom, 20)
                    
                    Label(transaction.fuelType, systemImage: "fuelpump")
                        .font(.title3)
                    Label(transaction.liters, systemImage: "speedometer")
                        .font(.title3)
                    
                    Divider()
                    Text(transaction.price)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.accentColor)
                }
                .frame(maxHeight: .infinity)
            }
            Spacer()
            if let url = URL(string: transaction.invoiceURL) {
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

struct FuelSingleTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        FuelSingleTransactionView(transaction: Mock.fuelTransactions.first!)
            .preferredColorScheme(.dark)
    }
}


enum FuelSingleTransactionViewStrings: String, CaseIterable {
    case downloadInvoice = "FuelSingleTransactionView_Download_The_Invoice" //"Download the invoice";
}
