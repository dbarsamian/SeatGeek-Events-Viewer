//
//  FavoritesData.swift
//  SeatGeat-EventsViewer
//
//  Created by David Barsamian on 4/10/21.
//

import CoreData
import Foundation
import UIKit

class FavoritesData {
    static let shared = FavoritesData()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func saveFavorites() {
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.saveContext()
    }
    
    func loadFavorites(with predicate: NSPredicate? = nil) -> [Event]? {
        let request: NSFetchRequest<Event> = Event.fetchRequest()
        request.predicate = predicate
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching favorited items! (\(error))")
            return nil
        }
    }
}
