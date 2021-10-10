//
//  LocationModel.swift
//  Africa
//
//  Created by Scott Clampet on 10/10/21.
//

import Foundation
import CoreLocation

struct NationalParkLocation: Codable, Identifiable {
    let id: String
    let name: String
    let image: String
    let latitude: Double
    let longitude: Double
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
