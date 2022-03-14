//
//  FitnessGraphView.swift
//  FitnessAppUI
//
//  Created by Scott Clampett on 3/14/22.
//

import SwiftUI

struct FitnessGraphView: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("Steps by hour")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            BarGraph(steps: steps)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 25)
        .background(
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .opacity(0.05)
        )
    }
}

struct FitnessGraphView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
