//
//  ContentView.swift
//  EcommerceTemplate
//
//  Created by Scott Clampet on 12/2/21.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var log_Status: Bool = false
    
    var body: some View {
        if log_Status {
            MainPage()
        } else {
            OnBoardingPage()            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
