//
//  NotificationHandler.swift
//  NoulTestament
//
//  Created by Vadim on 01/09/2024.
//

import SwiftUI
import UserNotifications

func handleNotifications() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if granted {
            scheduleNotifications()
        }
    }
}

private func scheduleNotifications() {
    let content = UNMutableNotificationContent()
    content.title = "Biblia - Noul Testament"
    content.body = "Nu uita să asculți din Cuvânt și azi!"
    content.sound = nil
    content.badge = 0
    
    var dateComponents = DateComponents()
    dateComponents.hour = 8
    dateComponents.minute = 0
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    let request = UNNotificationRequest(identifier: "daily_notification", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request)
}
