//
//  ContentView.swift
//  TaskManager
//
//  Created by Scott Clampet on 3/7/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        Text("Hello")
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
