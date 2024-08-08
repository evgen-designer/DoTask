//
//  AddActivityView.swift
//  DoTask
//
//  Created by Mac on 07/08/2024.
//

import SwiftUI

struct AddActivityView: View {
    @Bindable var activityStore: ActivityStore
    @State private var name = ""
    let selectedDate: Date
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Task name", text: $name)
            }
            .navigationTitle("Add task")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    let newActivity = Activity(name: name, isCompleted: false, date: selectedDate)
                    activityStore.activities.append(newActivity)
                    activityStore.save()
                    dismiss()
                }
                .disabled(name.isEmpty)
            )
        }
    }
}
