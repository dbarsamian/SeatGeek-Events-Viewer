//
//  EventsViewController.swift
//  SeatGeat-EventsViewer
//
//  Created by David Barsamian on 4/8/21.
//

import UIKit
import SDWebImage

class EventsViewController: UITableViewController {
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private var eventManager = EventManager()
    private var eventsData: SGEventsData?
    private var currentPage: Int = 1
    private var pagesLoaded: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventManager.delegate = self
        
        // Insert searchBar into navigation title view
        let searchController = UISearchController(searchResultsController: self)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
        // Set up refresh control
        refreshControl?.addTarget(self, action: #selector(self.didStartRefreshing(_:)), for: .valueChanged)
        // Fetch first page of events
        fetchEvents()
    }
    
    private func fetchEvents() {
        self.tableView.tableHeaderView = activityIndicator
        activityIndicator.startAnimating()
        eventManager.fetchEvents(for: currentPage)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return pagesLoaded
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let perPage = eventsData?.meta?.perPage else {
            return 0
        }
        return perPage
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCell
        // Get event
        guard let event = eventsData?.events?[indexPath.row] else {
            return cell
        }
        // Date label
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        if let dateString = event.datetimeLocal, let date = dateFormatter.date(from: dateString), let timezoneId = event.venue?.timezone, let timezone = TimeZone(identifier: timezoneId) {
            cell.dateLabel.text = "\(dateFormatter.string(from: date)) \(timezone.abbreviation() ?? "COULD NOT CREATE DATE")"
        }
        // Address label
        if let venue = event.venue, let address = venue.address, let extendedAddress = venue.extendedAddress {
            cell.locationLabel.text = "\(address) \(extendedAddress)"
        }
        // Title label
        cell.titleLabel.text = event.title
        // Image
        if let imageUrlString = event.performers?.first?.image {
            cell.thumbnailImage.sd_setImage(with: URL(string: imageUrlString), completed: nil)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Refresh Control
    @objc func didStartRefreshing(_ sender: AnyObject) {
        eventManager.fetchEvents(for: currentPage)
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if let refreshControl = self.refreshControl, refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
            self.activityIndicator.stopAnimating()
            self.tableView.tableHeaderView = nil
        }
    }
    
    func eventManager(_ eventManager: EventManager, didFailWithError error: Error) {
        print("ERROR! \(error)")
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
