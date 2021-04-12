//
//  EventManager.swift
//  SeatGeat-EventsViewer
//
//  Created by David Barsamian on 4/9/21.
//

import Foundation

/**
 An object that interacts with SeatGeek's public API to fetch data about events.
 
 
 # Setup
 To prepare a class to fetch events, create an `EventManager` instance and adopt the `EventManagerDelegate`
 protocol.
 
 # Usage
 To fetch a collection of events, call `fetchEvents(page:, with:)` with a page number and an optional query.
 If a query is provided, the function will ask SeatGeek's API to do a general search and return relevant results.
 If no query is provided, SeatGeek's API will return a collection of events sorted by date descending.
 */
struct EventManager {
    var delegate: EventManagerDelegate?
    
    private let baseUrl = "https://api.seatgeek.com/2/events"
    private let perPage = 25 // TODO: Make this configurable.
    
    /**
     Fetches a collection of events from SeatGeek's API and notifies the delegate if there is a result.
     
     - Parameters:
        - page: The page to retrieve from SeatGeek's API.
        - query: The optional search query to pass into SeatGeek's API. The default is an empty string.
     */
    func fetchEvents(page: Int, with query: String = "") {
        guard let secrets = getSecrets(), let client_id = secrets["client_id"], let api_key = secrets["api_key"] else {
            return
        }
        let urlString = "\(baseUrl)?client_id=\(client_id)&client_secret=\(api_key)&per_page=\(perPage)&page=\(page)&q=\(query)"
        performRequest(with: urlString)
    }
    
    fileprivate func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
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
    
    /**
     Retrieves a dictionary of secrets from a `Secrets.plist` file.
     
     - Returns: A dictionary containing all key-value pairs from the file. If the file was created correctly, it will return two key entries: `client_id` and `api_key`.
     */
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

/**
 Methods for responding to lifecycle updates from an Event Manager.
 
 Use the methods of this protocol to manage the following features:
 - Respond to newly fetched events.
 - Handle errors thrown from fetching events.
 */
protocol EventManagerDelegate {
    func eventManager(_ eventManager: EventManager, didUpdateEvents events: SGEventsData)
    func eventManager(_ eventManager: EventManager, didFailWithError error: Error)
}
