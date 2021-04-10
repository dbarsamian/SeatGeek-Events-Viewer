//
//  EventManager.swift
//  SeatGeat-EventsViewer
//
//  Created by David Barsamian on 4/9/21.
//

import Foundation

struct EventManager {
    var delegate: EventManagerDelegate?
    let baseUrl = "https://api.seatgeek.com/2/events"
    var currentPage = 1
    
    fileprivate func getSecrets() -> [String:String]? {
        guard let secretsPath = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
            print("Cannot find secrets path!")
            return nil
        }
        let url = URL(fileURLWithPath: secretsPath)
        guard let data = try? Data(contentsOf: url) else {
            print("Cannot get secrets data!")
            return nil
        }
        guard let plist = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String:String] else {
            print("Cannot serialize plist!")
            return nil
        }
        return plist
    }
    
    
}

protocol EventManagerDelegate {
    func eventManager(_ eventManager: EventManager, didUpdateEvents events: SGEventsData)
    func eventManager(_ eventManager: EventManager, didFailWithError error: Error)
}
