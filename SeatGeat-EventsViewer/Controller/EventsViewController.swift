//
//  EventsViewController.swift
//  SeatGeat-EventsViewer
//
//  Created by David Barsamian on 4/8/21.
//

import SDWebImage
import UIKit

class EventsViewController: UITableViewController {
    private var eventManager = EventManager()
    private var eventsData: SGEventsData?
    private var currentPage: Int = 1
    private var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        eventManager.delegate = self

        // Insert searchBar into navigation title view
        let searchController = UISearchController(searchResultsController: presentingViewController)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController

        // Set up refresh control
        refreshControl?.addTarget(self, action: #selector(didStartRefreshing(_:)), for: .valueChanged)
        // Fetch first page of events
        fetchEvents()
    }

    private func fetchEvents(with query: String = "") {
        if #available(iOS 13.0, *) {
            self.tableView.tableHeaderView = activityIndicator
            activityIndicator.startAnimating()
            activityIndicator.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 44)
        }
        eventManager.fetchEvents(page: currentPage, with: query)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
        if let datetimeLocal = event.datetimeLocal, let tzString = event.venue?.timezone, let timezone = TimeZone(identifier: tzString) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            formatter.timeZone = timezone
            if let date = formatter.date(from: datetimeLocal) {
                formatter.dateStyle = .long
                formatter.timeStyle = .long
                let dateString = formatter.string(from: date)
                cell.dateLabel.text = dateString
            }
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
        performSegue(withIdentifier: "detailSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Refresh Control

    @objc func didStartRefreshing(_ sender: AnyObject) {
        eventManager.fetchEvents(page: currentPage)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destViewCtrl = segue.destination as? DetailViewController, let selectedIndexPath = self.tableView.indexPathForSelectedRow, let events = eventsData?.events {
            destViewCtrl.event = events[selectedIndexPath.row]
        }
    }
}

// MARK: - Event Manager Delegate

extension EventsViewController: EventManagerDelegate {
    func eventManager(_ eventManager: EventManager, didUpdateEvents events: SGEventsData) {
        eventsData = events
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if let refreshControl = self.refreshControl, refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
            if #available(iOS 13.0, *) {
                self.activityIndicator.stopAnimating()
                self.tableView.tableHeaderView = nil
            }
        }
    }

    func eventManager(_ eventManager: EventManager, didFailWithError error: Error) {
        print("ERROR! \(error)")
    }
}

// MARK: - Search Controller Delegate

extension EventsViewController: UISearchControllerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.lowercased() else {
            return
        }
        fetchEvents(with: searchText)
        searchBar.text = ""
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Search Results Updating

extension EventsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {}
}

// MARK: - Search Bar Delegate

extension EventsViewController: UISearchBarDelegate {}
