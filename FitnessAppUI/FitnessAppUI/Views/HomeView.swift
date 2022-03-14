//
//  HomeView.swift
//  FitnessAppUI
//
//  Created by Scott Clampett on 3/14/22.
//

import SwiftUI

struct HomeView: View {
    //MARK: Properties
    @State var currentWeek: [Date] = []
    @State var currentDay: Date = Date()
    
    var body: some View {
        VStack(spacing: 20) {
            //MARK: Title + Ellipsis
            HStack {
                Text("Current Week")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title3)
                }
            }
            .foregroundColor(.white)
            
            //MARK: Current Week View
            HStack(spacing: 10) {
                ForEach(currentWeek, id: \.self) { date in
                    Text(extractCustomDate(from: date))
                        .fontWeight(areSameDay(date1: currentDay, date2: date) ? .bold : .semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, areSameDay(date1: currentDay, date2: date) ? 6 : 0)
                        .padding(.horizontal, areSameDay(date1: currentDay, date2: date) ? 10 : 0)
                        .frame(width: areSameDay(date1: currentDay, date2: date) ? 140 : nil)
                        .background(
                            Capsule()
                                .fill(Color.white)
                                .opacity(areSameDay(date1: currentDay, date2: date) ? 0.4 : 0.15)
                        )
                        .onTapGesture {
                            withAnimation {
                                currentDay = date
                            }
                        }
                }
            }
            .padding(.top, 10)
            
            //MARK: Steps
            VStack(alignment: .leading, spacing: 8) {
                Text("Steps")
                    .fontWeight(.semibold)
                
                Text("6,243")
                    .font(.system(size: 45, weight: .bold))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 15)
            
            //MARK: Progress Ring View
            ProgressRingCardView()
            
            //MARK: Fitness Bar Graph
            FitnessGraphView()
        }
        .padding()
        .onAppear(perform: extractCurrnetWeek)
    }
    
    //MARK: Private Methods
    func extractCurrnetWeek() {
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: Date())
        
        guard let firstDayOfWeek = week?.start else {
            return
        }
        
        (0..<7).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstDayOfWeek) {
                currentWeek.append(weekDay)
            } else {
                print("Unable to get weekday")
            }
        }
    }
    
    func extractCustomDate(from date: Date) -> String {
        let areSameDates = areSameDay(date1: currentDay, date2: date)
        let formatter = DateFormatter()
        formatter.dateFormat = areSameDates ? "dd MMM" : "dd"
        
        return (isToday(date: date) && areSameDates ? "Today, " : "" ) + formatter.string(from: date)
    }
    
    func isToday(date: Date) -> Bool {
        return Calendar.current.isDateInToday(date)
    }
    
    func areSameDay(date1: Date, date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
