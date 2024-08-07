//
//  Activity.swift
//  DoTask
//
//  Created by Mac on 07/08/2024.
//

import Foundation

struct Activity: Codable, Identifiable, Equatable {
    var id = UUID()
    var name: String
    var isCompleted: Bool
    var date: Date
    var description: String?
    
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        lhs.id == rhs.id
    }
}
