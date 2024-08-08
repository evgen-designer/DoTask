//
//  ActivityRow.swift
//  DoTask
//
//  Created by Mac on 07/08/2024.
//

import SwiftUI

struct ActivityRow: View {
    @State var activity: Activity
    @Bindable var activityStore: ActivityStore
    @State private var showingDetail = false
    
    var body: some View {
        HStack {
            Button(action: {
                toggleCompletion()
            }) {
                Image(systemName: activity.isCompleted ? "checkmark.circle.fill" : "circle")
            }
            
            Text(activity.name)
            
            if activity.description != nil {
                Spacer()
                Image(systemName: "doc.text")
                    .foregroundColor(.gray)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            showingDetail = true
        }
        .sheet(isPresented: $showingDetail) {
            ActivityDetailView(activity: $activity, activityStore: activityStore)
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                deleteActivity()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .swipeActions(edge: .leading) {
            Button {
                copyActivity()
            } label: {
                Label("Dublicate", systemImage: "doc.on.doc")
            }
            .tint(.blue)
        }
    }
    
    func toggleCompletion() {
        if let index = activityStore.activities.firstIndex(of: activity) {
            activityStore.activities[index].isCompleted.toggle()
            activityStore.save()
        }
    }
    
    func deleteActivity() {
        if let index = activityStore.activities.firstIndex(of: activity) {
            activityStore.activities.remove(at: index)
            activityStore.save()
        }
    }
    
    func copyActivity() {
        var newActivity = activity
        newActivity.id = UUID()
        activityStore.activities.append(newActivity)
        activityStore.save()
    }
}
