//
//  WeekCalendarView.swift
//  DoTask
//
//  Created by Mac on 07/08/2024.
//

import SwiftUI

struct WeekCalendarView: View {
    @Binding var selectedDate: Date
    @State private var currentDate = Date()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(-3...3, id: \.self) { offset in
                    let date = Calendar.current.date(byAdding: .day, value: offset, to: currentDate)!
                    DateButton(date: date, isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate), isToday: Calendar.current.isDateInToday(date)) {
                        selectedDate = date
                    }
                }
            }
            .padding()
        }
    }
}
