//
//  Date+Past.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import Foundation

extension Date {
    func friendlyTimeAgo() -> String {
        let now = Date()
        let calendar = Calendar.current
        let minutes = calendar.date(byAdding: .minute, value: -1, to: now)!
        let hours = calendar.date(byAdding: .hour, value: -1, to: now)!
        let days = calendar.date(byAdding: .day, value: -1, to: now)!
        let weeks = calendar.date(byAdding: .day, value: -7, to: now)!

        if minutes < self {
            let delta = Calendar.current.dateComponents([.second], from: self, to: now).second ?? 0
            return "\(delta) sec ago"
        } else if hours < self {
            let delta = Calendar.current.dateComponents([.minute], from: self, to: now).minute ?? 0
            return "\(delta) min ago"
        } else if days < self {
            let delta = Calendar.current.dateComponents([.hour], from: self, to: now).hour ?? 0
            return "\(delta) hours ago"
        } else if weeks < self {
            let delta = Calendar.current.dateComponents([.day], from: self, to: now).day ?? 0
            return "\(delta) days ago"
        } else {
            let delta = Calendar.current.dateComponents([.weekOfYear], from: self, to: now).weekOfYear ?? 0
            if delta < 4 {
                return "\(delta) weeks ago"
            } else {
                return friendlyDate()
            }
        }
    }
    
    func friendlyDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d ''yy"
        return formatter.string(from: self)
    }
}
