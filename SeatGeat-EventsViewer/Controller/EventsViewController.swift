//
//  EventsViewController.swift
//  SeatGeat-EventsViewer
//
//  Created by David Barsamian on 4/8/21.
//

import UIKit

class EventsViewController: UITableViewController {
    
    private var eventManager = EventManager()
    private var eventsData: SGEventsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Insert searchBar into navigation title view
        let searchController = UISearchController(searchResultsController: self)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
        // Fetch first page of events
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let perPage = eventsData?.meta.perPage else {
            return 10
        }
        return perPage
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCell
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

// MARK: - Event Manager Delegate

extension EventsViewController: EventManagerDelegate {
    func eventManager(_ eventManager: EventManager, didUpdateEvents events: SGEventsData) {
        self.eventsData = events
    }
    
    func eventManager(_ eventManager: EventManager, didFailWithError error: Error) {
        
    }
    
}

// MARK: - Search Controller Delegate

extension EventsViewController: UISearchControllerDelegate {}

// MARK: - Search Results Updating

extension EventsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}

// MARK: - Search Bar Delegate

extension EventsViewController: UISearchBarDelegate {
    
}
