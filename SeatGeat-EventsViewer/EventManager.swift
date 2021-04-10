//
//  EventManager.swift
//  SeatGeat-EventsViewer
//
//  Created by David Barsamian on 4/9/21.
//

import Foundation

struct EventManager {
    var delegate: EventManagerDelegate?
    
    private let baseUrl = "https://api.seatgeek.com/2/events"
    private let perPage = 25
    
    func fetchEvents(for page: Int) {
        guard let secrets = getSecrets(), let client_id = secrets["client_id"], let api_key = secrets["api_key"] else {
            return
        }
        let urlString = "\(baseUrl)?client_id=\(client_id)&client_secret=\(api_key)&per_page=\(perPage)&page=\(page)"
        performRequest(with: urlString)
    }
    
    fileprivate func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            print("EventManager: Created url: \(url.absoluteString)")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    self.delegate?.eventManager(self, didFailWithError: error!)
                    return
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    do {
                        let events = try decoder.decode(SGEventsData.self, from: safeData)
                        self.delegate?.eventManager(self, didUpdateEvents: events)
                    } catch {
                        print("EventManager: JSON Decoding Error: \(error)")
                    }
                }
            }
            task.resume()
        }
    }
    
    fileprivate func getSecrets() -> [String: String]? {
        guard let secretsPath = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
            print("Cannot find secrets path!")
            return nil
        }
        let url = URL(fileURLWithPath: secretsPath)
        guard let data = try? Data(contentsOf: url) else {
            print("Cannot get secrets data!")
            return nil
        }
        guard let plist = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: String] else {
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
