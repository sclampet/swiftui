//
//  CovidAPIService.swift
//  CovidTracker
//
//  Created by Scott Clampet on 9/28/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class CovidAPIService: ObservableObject {
    @Published var totalData: TotalData = testTotalData
    @Published var allCountries: [CountryData] = []
    
    let headers: HTTPHeaders = [
        "x-rapidapi-host": "covid-19-data.p.rapidapi.com",
        "x-rapidapi-key": "d172e810e7msh47584ae043c146dp12d8eejsnb0b3c42c4a59"
    ]
    
    init() {
        getCurrentTotals()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.getCountryData(for: "Poland")
        }
    }
    
    func getCurrentTotals() {
        AF.request("https://covid-19-data.p.rapidapi.com/totals", headers: headers).responseJSON { response in
            
            guard let result = response.data else {
                self.totalData = testTotalData
                return
            }
            
            let json = JSON(result)
            let confirmed = json[0]["confirmed"].intValue
            let recovered = json[0]["recovered"].intValue
            let deaths = json[0]["deaths"].intValue
            let critical = json[0]["critical"].intValue
            
            self.totalData = TotalData(confirmed: confirmed, critical: critical, deaths: deaths, recovered: recovered)
        }
    }
    
    func getCountryData(for name: String) {
        AF.request("https://covid-19-data.p.rapidapi.com/country/all", headers: headers).responseJSON { response in
            
            guard let result = response.value else { return }
            
            let dataDict = result as! [Dictionary<String, AnyObject>]
            var allCount: [CountryData] = []
            
            for countryData in dataDict {
                let country = countryData["country"] as? String ?? "Error"
                let longitude = countryData["longitude"] as? Double ?? 0.0
                let latitude = countryData["latitude"] as? Double ?? 0.0
                let confirmed = countryData["confirmed"] as? Int64 ?? 0
                let recovered = countryData["recovered"] as? Int ?? 0
                let deaths = countryData["deaths"] as? Int64 ?? 0
                let critical = countryData["critical"] as? Int64 ?? 0
                
                let countryObj = CountryData(country: country, confirmed: confirmed, critical: critical, deaths: deaths, recovered: recovered, longitutde: longitude, latitude: latitude)
                
                allCount.append(countryObj)
            }
            
            self.allCountries = allCount
        }
    }
}
