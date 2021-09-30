//
//  CountryDataRowView.swift
//  CovidTracker
//
//  Created by Scott Clampet on 9/29/21.
//

import SwiftUI

struct CountryDataRowView: View {
    var countryData: CountryData
    
    var body: some View {
        HStack {
            Text(countryData.country)
                .fontWeight(.medium)
                .font(.subheadline)
                .frame(height: 30, alignment: .leading)
                .lineLimit(2)
            
            Spacer()
            Text(countryData.confirmed.formatNumber())
                .font(.subheadline)
                .frame(height: 40)
                .padding(.leading, 5)

            Spacer()
            Text(countryData.deaths.formatNumber())
                .fontWeight(.medium)
                .font(.subheadline)
                .frame(width: 50, alignment: .center)
                .padding(.leading, 5)
                .foregroundColor(.red)
            
            Spacer()
            Text(countryData.recovered.formatNumber())
                .fontWeight(.medium)
                .font(.subheadline)
                .frame(width: 50, alignment: .center)
                .foregroundColor(.green)
        }
    }
}

struct CountryDataRowView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDataRowView(countryData: testCountryData)
    }
}
