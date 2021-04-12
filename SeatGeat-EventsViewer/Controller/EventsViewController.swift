//
//  EventsViewController.swift
//  SeatGeat-EventsViewer
//
//  Created by David Barsamian on 4/8/21.
//

import CoreData
import SDWebImage
import UIKit

/**
 An object that displays a list of events from SeatGeek's public API.

 An event view uses a table view to display a single column of events from SeatGeek's public API.
 */
class EventsViewController: UITableViewController {
    // Data
    private var eventManager = EventManager()
    private var eventsData: SGEventsData?
    private var events: [SGEvent] = [SGEvent]()
    private var currentPage: Int = 1
    private var currentQuery: String = ""
    private var isFetching = false
    // UI
    private var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var resetSearchButton: UIBarButtonItem!
    // CoreData
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var favoritedEvents: [FavoritedEvent]?

    // MARK: - View
    
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
        
        // Set up reset search bar button
        resetSearchButton.target = self
        resetSearchButton.action = #selector(clearSearchAndFetch)

        // Set up favorites
        favoritedEvents = FavoritesData.shared.loadFavorites()

        // Fetch first page of events
        fetchEvents(with: self.currentQuery)
    }

    override func viewWillAppear(_ animated: Bool) {
        favoritedEvents = FavoritesData.shared.loadFavorites()
        tableView.reloadData()
    }

    // MARK: - Internal
    
    private func fetchEvents(with query: String) {
        self.isFetching = true
        if #available(iOS 13.0, *) {
            self.tableView.tableHeaderView = activityIndicator
            activityIndicator.startAnimating()
            activityIndicator.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 44)
        }
        eventManager.fetchEvents(page: currentPage, with: query)
    }
    
    @objc private func clearSearchAndFetch() {
        navigationItem.leftBarButtonItem = nil
        currentQuery = ""
        clearAndFetchWithQuery(currentQuery)
    }
    
    private func clearAndFetchWithQuery(_ query: String) {
        isFetching = true
        currentQuery = query
        currentPage = 1
        events.removeAll()
        eventsData = nil
        fetchEvents(with: currentQuery)
    }
    
    private func presentAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func createDateString(with inputString: String, at timeZoneString: String?) -> String? {
        var formatter: DateFormatter {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            if let timeZoneString = timeZoneString {
                df.timeZone = TimeZone(identifier: timeZoneString)
            }
            return df
        }
        if let date = formatter.date(from: inputString) {
            formatter.dateStyle = .long
            formatter.timeStyle = .long
            let dateString = formatter.string(from: date)
            return dateString
        } else {
            return nil
        }
    }
    
    private func setCellFavorited(_ cell: EventCell, with event: SGEvent) {
        if let favoritedEvents = favoritedEvents, let eventId = event.id {
            let isFavorite = favoritedEvents.contains { (element) -> Bool in
                if element.eventId == eventId {
                    return true
                } else {
                    return false
                }
            }
            if isFavorite {
                if #available(iOS 13.0, *) {
                    cell.favoritesImage.image = UIImage(systemName: "heart.fill")
                } else {
                    cell.favoritesImage.image = UIImage(named: "heart.fill")
                }
            } else {
                cell.favoritesImage.image = nil
            }
            cell.favoritesImage.layer.shadowColor = UIColor.black.cgColor
            cell.favoritesImage.layer.shadowOpacity = 0.5
            cell.favoritesImage.layer.shadowOffset = .init(width: 0, height: 1)
            cell.favoritesImage.layer.shadowRadius = 2
            cell.favoritesImage.layer.shouldRasterize = true
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCell
        guard events.count > 0 else {
            self.currentQuery = ""
            self.fetchEvents(with: currentQuery)
            presentAlert(title: "No Results Found", message: "No results found. Try searching for something else.", preferredStyle: .alert)
            return cell
        }
        
        // Get event
        let event = self.events[indexPath.row]
        
        // Date label
        if let datetimeLocal = event.datetimeLocal, let tzString = event.venue?.timezone, let dateString = createDateString(with: datetimeLocal, at: tzString) {
            cell.dateLabel.text = dateString
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
        
        // Check if favorited
        setCellFavorited(cell, with: event)
        
        return cell
    }
    
    // MARK: - Scroll view
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height {
            if !isFetching {
                self.currentPage += 1
                self.fetchEvents(with: currentQuery)
            }
        }
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
        if let destViewCtrl = segue.destination as? DetailViewController, let selectedIndexPath = tableView.indexPathForSelectedRow {
            destViewCtrl.event = events[selectedIndexPath.row]
        }
    }
}

// MARK: - Event Manager Delegate

extension EventsViewController: EventManagerDelegate {
    func eventManager(_ eventManager: EventManager, didUpdateEvents eventsData: SGEventsData) {
        DispatchQueue.main.async {
            self.eventsData = eventsData
            if let events = self.eventsData!.events {
                self.events.append(contentsOf: events)
            }
            self.tableView.reloadData()
            if let refreshControl = self.refreshControl, refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
            if #available(iOS 13.0, *) {
                self.activityIndicator.stopAnimating()
                self.tableView.tableHeaderView = nil
            }
            self.isFetching = false
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
        currentQuery = searchText
        clearAndFetchWithQuery(currentQuery)
        self.navigationItem.leftBarButtonItem = resetSearchButton
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
