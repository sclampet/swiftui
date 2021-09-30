//
//  ContentView.swift
//  CovidTracker
//
//  Created by Scott Clampet on 9/28/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RecentView()
                .tabItem { Tab(imageName: "chart.bar", text: "Recent") }
        }
        .tag(0)
        
        // map will be 2nd tab
    }
}

private struct Tab: View {
    let imageName: String
    let text: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
            Text(text)
        }
    }
}
