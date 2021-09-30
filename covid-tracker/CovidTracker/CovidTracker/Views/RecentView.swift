//
//  RecentView.swift
//  CovidTracker
//
//  Created by Scott Clampet on 9/29/21.
//

import Foundation
import SwiftUI

struct RecentView: View {
    @ObservedObject var covidAPIService = CovidAPIService()
    
    var body: some View {
            NavigationView {
            VStack {
                ListHeaderView()
                List {
                    ForEach(covidAPIService.allCountries.filter {
                        self.searchText.isEmpty ? true : $0.country.lowercased().contains(self.searchText.low)
                    })
                }
            }
        }
    }
}

struct RecentView_Previews: PreviewProvider {
    static var previews: some View {
        RecentView()
    }
}
