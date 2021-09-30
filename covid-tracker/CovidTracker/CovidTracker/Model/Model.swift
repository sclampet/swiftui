//
//  Model.swift
//  CovidTracker
//
//  Created by Scott Clampet on 9/28/21.
//

import Foundation

struct TotalData {
    let confirmed: Int
    let critical: Int
    let deaths: Int
    let recovered: Int
    
    var fatalityRate: Double {
        return (100 * Double(deaths)) / Double(confirmed)
    }
    
    var recoveryRate: Double {
        return (100 * Double(recovered)) / Double(confirmed)
    }
}

struct CountryData {
    let country: String
    let confirmed: Int64
    let critical: Int64
    let deaths: Int64
    let recovered: Int
    let longitutde: Double
    let latitude: Double
    
    var fatalityRate: Double {
        return (100 * Double(deaths)) / Double(confirmed)
    }
    
    var recoveryRate: Double {
        return (100 * Double(recovered)) / Double(confirmed)
    }
}

let testTotalData = TotalData(confirmed: 0, critical: 0, deaths: 0, recovered: 0)
let testCountryData = CountryData(country: "test", confirmed: 0, critical: 0, deaths: 0, recovered: 0, longitutde: 0.0, latitude: 0.0)
