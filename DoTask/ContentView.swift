//
//  ContentView.swift
//  DoTask
//
//  Created by Mac on 07/08/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var activityStore = ActivityStore()
    @State private var showingAddActivity = false
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                WeekCalendarView(selectedDate: $selectedDate)
                
                List {
                    Section(header: Text("To-Do")) {
                        ForEach(activitiesForSelectedDate.filter { !$0.isCompleted }) { activity in
                            ActivityRow(activity: activity, activityStore: activityStore)
                        }
                        .onMove(perform: moveActivity)
                        .onDelete(perform: deleteActivity)
                    }
                    
                    Section(header: Text("Done")) {
                        ForEach(activitiesForSelectedDate.filter { $0.isCompleted }) { activity in
                            ActivityRow(activity: activity, activityStore: activityStore)
                        }
                        .onDelete(perform: deleteActivity)
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Habits")
            .overlay(
                Button(action: {
                    showingAddActivity = true
                }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(),
                alignment: .bottomTrailing
            )
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(activityStore: activityStore, selectedDate: selectedDate)
            }
        }
    }
    
    var activitiesForSelectedDate: [Activity] {
        activityStore.activities.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }
    
    func moveActivity(from source: IndexSet, to destination: Int) {
        activityStore.activities.move(fromOffsets: source, toOffset: destination)
        activityStore.save()
    }
    
    func deleteActivity(at offsets: IndexSet) {
        activityStore.activities.remove(atOffsets: offsets)
        activityStore.save()
    }
}

#Preview {
    ContentView()
}
