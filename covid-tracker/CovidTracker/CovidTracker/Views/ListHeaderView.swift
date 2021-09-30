//
//  ListHeaderView.swift
//  CovidTracker
//
//  Created by Scott Clampet on 9/29/21.
//

import SwiftUI

struct ListHeaderView: View {
    var body: some View {
        HStack {
            Text("Country")
                .fontWeight(.bold)
                .font(.subheadline)
                .frame(height: 15, alignment: .leading)
                .padding(.leading, 15)
            
            Spacer()
            Text("Conf.")
                .fontWeight(.bold)
                .font(.subheadline)
                .frame(height: 40)
                .padding(.leading, 5)

            Spacer()
            Text("Deaths")
                .fontWeight(.bold)
                .font(.subheadline)
                .frame(height: 40)
                .padding(.leading, 5)
            
            Spacer()
            Text("Recovered")
                .fontWeight(.bold)
                .font(.subheadline)
                .frame(height: 40)
                .padding(.trailing, 5)
        }
        .background(Color.gray)
    }
}

struct ListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderView()
    }
}
