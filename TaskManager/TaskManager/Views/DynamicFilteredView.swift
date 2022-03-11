//
//  DynamicFilteredView.swift
//  TaskManager
//
//  Created by Scott Clampet on 3/10/22.
//

import SwiftUI
import CoreData

//@FetchRequest can be called only once and cannot be sorted or filtered so we use this view to dynamically update the FetchRequest
struct DynamicFilteredView<Content: View, T>: View where T: NSManagedObject {
    //MARK: Core Data Request
    @FetchRequest var request: FetchedResults<T>
    let content: (T) -> Content
    
    //MARK: Building custom ForEach which will use CoreData object to build the View
    init(dateToFilter: Date, @ViewBuilder content: @escaping (T) -> Content) {
        //Predicate to filter tasks by dateToFilter
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: dateToFilter)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        let filterKey = "date"
        //Filters tasks between 'today' and 'tomorrow' (24 hours)
        let predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@", argumentArray: [today, tomorrow])
        
        //Initialize request with NSPredicate
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.date, ascending: false)], predicate: predicate)
        self.content = content
    }
    
    var body: some View {
        Group {
            if request.isEmpty {
                Text("No tasks found")
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .offset(y: 100)
            } else {
                ForEach(request, id: \.objectID) { object in
                    self.content(object)
                }
            }
        }
    }
}
