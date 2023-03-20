//
//  PointOfInterest.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import Foundation
import MapKit

struct PointOfInterest: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
    
