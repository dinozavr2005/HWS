//
//  ViewController.swift
//  HWSProject-21
//
//  Created by Владимир on 25.01.2022.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(initialSchedule))
    }

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Yay")
            }
            else {
                print("D'oh")
            }
        }
    }
    
    @objc func initialSchedule() {
        scheduleLocal(delaySeconds: 5)
    }

    @objc func scheduleLocal(delaySeconds: TimeInterval) {
        registerCategories()

        let center = UNUserNotificationCenter.current()

        // not required, but useful for testing!
        // avoid sending multiple notifications when schedule is tapped multiple times
        center.removeAllPendingNotificationRequests()

        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        // example of daily notification at a fixed time
//        var dateComponents = DateComponents()
//        dateComponents.hour = 10
//        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delaySeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }

    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more", options: .foreground)
        // challenge 2
        // use authenticationRequired so that app does not get opened
        let delay = UNNotificationAction(identifier: "delay", title: "Remind me later", options: .authenticationRequired)
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, delay], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // pull out the buried userInfo dictionary
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock; do nothing
                // challenge 1
                let ac = UIAlertController(title: "Swipe", message: "The user swiped to unlock", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
                
            case "show":
                // challenge 1
                let ac = UIAlertController(title: "Button", message: "The user tapped the \"Tell me more\" button", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
                
                // challenge 2
            case "delay":
                scheduleLocal(delaySeconds: 3600*24)
                
            default:
                break
            }
        }

        // you need to call the completion handler when you're done
        completionHandler()
    }
}

