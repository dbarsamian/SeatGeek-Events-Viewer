//
//  DetailViewController.swift
//  SeatGeat-EventsViewer
//
//  Created by David Barsamian on 4/10/21.
//

import CoreData
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var headlineImage: UIImageView!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var favoriteButton: UIBarButtonItem!
    
    var event: SGEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteButton.target = self
        favoriteButton.action = #selector(toggleFavorite)
        
        if let event = event {
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
            if let cityString = event.venue?.city, let stateString = event.venue?.state {
                locationLabel.text = "\(cityString), \(stateString)"
            }
            if let imgUrlString = event.performers?.first?.image {
                headlineImage.sd_setImage(with: URL(string: imgUrlString), completed: nil)
            }
            if let titleString = event.title {
                titleLabel.text = titleString
            }
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

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
