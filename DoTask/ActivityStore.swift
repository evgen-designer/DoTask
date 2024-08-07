//
//  ActivityStore.swift
//  DoTask
//
//  Created by Mac on 07/08/2024.
//

import Foundation
import SwiftUI

@Observable class ActivityStore: ObservableObject {
    var activities: [Activity] = []
    
    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: "SavedActivities") {
            if let decodedActivities = try? JSONDecoder().decode([Activity].self, from: savedActivities) {
                activities = decodedActivities
                return
            }
        }
        activities = []
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(activities) {
            UserDefaults.standard.set(encoded, forKey: "SavedActivities")
        }
    }
}
