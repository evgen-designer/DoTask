//
//  ActivityDetailView.swift
//  DoTask
//
//  Created by Mac on 07/08/2024.
//

import SwiftUI

struct ActivityDetailView: View {
    @Binding var activity: Activity
    @Bindable var activityStore: ActivityStore
    @State private var description = ""
    @State private var date = Date()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Activity name", text: $activity.name)
                
                DatePicker("Date", selection: $date, displayedComponents: .date)
                
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                }
            }
            .navigationTitle("Edit Activity")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    if let index = activityStore.activities.firstIndex(of: activity) {
                        activity.date = date
                        activity.description = description.isEmpty ? nil : description
                        activityStore.activities[index] = activity
                        activityStore.save()
                    }
                    dismiss()
                }
            )
            .onAppear {
                date = activity.date
                description = activity.description ?? ""
            }
        }
    }
}
