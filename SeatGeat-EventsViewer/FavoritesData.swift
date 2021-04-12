//
//  FavoritesData.swift
//  SeatGeat-EventsViewer
//
//  Created by David Barsamian on 4/10/21.
//

import CoreData
import Foundation
import UIKit

/**
 An object that provides utilites for interacting with Core Data.
 
 Use this object when performing operations with Core Data, namely when saving or loading data.
 `FavoritesData` also implements the following behavior:
 
 - It sets the context's merge policy to disallow duplicates and to merge duplicates using the already stored object.
 - It allows searching with a predicate via `loadFavorites(with:)`
 */
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
