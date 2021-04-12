//
//  DetailViewController.swift
//  SeatGeat-EventsViewer
//
//  Created by David Barsamian on 4/10/21.
//

import CoreData
import UIKit

/**
 An object that displays information from an event.
 - Precondition: An event must be provided during construction and prior to presentation.
 */
class DetailViewController: UIViewController {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var headlineImage: UIImageView!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var favoriteButton: UIBarButtonItem!
    @IBOutlet private var actionButton: UIBarButtonItem!
    
    var event: SGEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up favorite button
        favoriteButton.target = self
        favoriteButton.action = #selector(toggleFavorite)
        
        // Set up action button
        actionButton.target = self
        actionButton.action = #selector(presentActivitySheet)
        
        // Set information views
        if let event = event {
            // Date Label
            if let datetimeLocal = event.datetimeLocal, let tzString = event.venue?.timezone, let timezone = TimeZone(identifier: tzString) {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                formatter.timeZone = timezone
                if let date = formatter.date(from: datetimeLocal) {
                    formatter.dateStyle = .long
                    formatter.timeStyle = .long
                    let dateString = formatter.string(from: date)
                    dateLabel.text = dateString
                }
            }
            // Location Label
            if let cityString = event.venue?.city, let stateString = event.venue?.state {
                locationLabel.text = "\(cityString), \(stateString)"
            }
            // Headline Image
            if let imgUrlString = event.performers?.first?.image {
                headlineImage.sd_setImage(with: URL(string: imgUrlString), completed: nil)
            }
            // Title Label
            if let titleString = event.title {
                titleLabel.text = titleString
            }
            // Favorite Bar Button Image
            if let eventId = event.id {
                let favoritedEvents = FavoritesData.shared.loadFavorites()
                if let favoritedEvents = favoritedEvents, favoritedEvents.count <= 0 {
                    updateButtonImage(isFavorited: false)
                } else {
                    let isFavorite = favoritedEvents?.contains(where: { (element) -> Bool in
                        if element.eventId == Int64(eventId) {
                            return true
                        } else {
                            return false
                        }
                    })
                    if let isFavorite = isFavorite, isFavorite == true {
                        updateButtonImage(isFavorited: true)
                    } else {
                        updateButtonImage(isFavorited: false)
                    }
                }
            }
        }
    }
    
    /**
     Toggles the favorited status of an event based on it's current favorited status.
     If an event is already favorited, it will be un-favorited, and vice versa.
     */
    @objc private func toggleFavorite() {
        guard var favoritedEvents = FavoritesData.shared.loadFavorites(), let eventId = event?.id else {
            return
        }
        if favoritedEvents.count < 1 { // If there are no favorited events
            // Favorite this event
            let event = Event(context: FavoritesData.shared.context)
            event.eventId = Int64(eventId)
            favoritedEvents.append(event)
            DispatchQueue.main.async {
                self.updateButtonImage(isFavorited: true)
            }
        } else { // If there are existing favorited events
            // Search for an event with our eventId
            let predicate = NSPredicate(format: "eventId == %@", NSNumber(integerLiteral: eventId))
            if let filteredEvents = FavoritesData.shared.loadFavorites(with: predicate) {
                if filteredEvents.count > 0 { // Remove the event if found
                    let event = filteredEvents.first!
                    let eventIndex = favoritedEvents.firstIndex(of: event)
                    favoritedEvents.remove(at: eventIndex!)
                    FavoritesData.shared.context.delete(event)
                    DispatchQueue.main.async {
                        self.updateButtonImage(isFavorited: false)
                    }
                } else {
                    let event = Event(context: FavoritesData.shared.context)
                    event.eventId = Int64(eventId)
                    favoritedEvents.append(event)
                    DispatchQueue.main.async {
                        self.updateButtonImage(isFavorited: true)
                    }
                }
            }
        }
        FavoritesData.shared.saveFavorites()
    }
    
    /**
     Creates an activity view that gives the user the option to open the current
     event as a link in either Safari or the SeatGeek app.
     */
    @objc private func presentActivitySheet() {
        if let eventUrl = event?.url, let eventId = event?.id, let safariUrl = URL(string: eventUrl), let seatgeekUrl = URL(string: "seatgeek://events/\(eventId)") {
            var imageSafari: UIImage? {
                if #available(iOS 13.0, *) {
                    return UIImage(systemName: "safari")
                } else {
                    return UIImage(named: "safari")
                }
            }
            let imageSeatGeek = UIImage(named: "seatgeek")
            let items: [URL] = [safariUrl]
            var activities = [UIActivity]()
            
            if UIApplication.shared.canOpenURL(safariUrl) {
                let openInSafari = Activity(title: "Open in Safari", image: imageSafari) { _ in
                    UIApplication.shared.open(safariUrl)
                }
                activities.append(openInSafari)
            }
            if UIApplication.shared.canOpenURL(seatgeekUrl) {
                let openInSG = Activity(title: "Open in SeatGeek", image: imageSeatGeek) { _ in
                    UIApplication.shared.open(seatgeekUrl)
                }
                activities.append(openInSG)
            }
            let ac = UIActivityViewController(activityItems: items, applicationActivities: activities)
            present(ac, animated: true)
        }
    }
    
    /**
     Updates the bar button image for the favorite button. If an event is favorited,
     then a filled heart will display on the item. If an event is not favorited,
     then a hollow heart will display on the item.
     - Parameter isFavorited: Is the current event favorited?
     */
    fileprivate func updateButtonImage(isFavorited: Bool) {
        if isFavorited {
            if #available(iOS 13.0, *) {
                favoriteButton.image = UIImage(systemName: "heart.fill")
            } else {
                favoriteButton.image = UIImage(named: "heart.fill")
            }
        } else {
            if #available(iOS 13.0, *) {
                favoriteButton.image = UIImage(systemName: "heart")
            } else {
                favoriteButton.image = UIImage(named: "heart")
            }
        }
    }
}
