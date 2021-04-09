//
//  EventModel.swift
//  SeatGeat-EventsViewer
//
//  Created by David Barsamian on 4/8/21.
//

import Foundation

struct Event: Codable {
    var stats: Stats
    var title: String
    var url: String
    var datetime_local: Date
    var performers: [Performers]
    var venue: Venue
    var short_title: String
    var datetime_utc: Date
    var score: Double
    var taxonomies: [Taxonomy]
    var type: String
    var id: Int
}

struct Stats: Codable {
    var listing_count: Int
    var average_price: Int
    var lowest_price: Int
    var highest_price: Int
}

struct Performers: Codable {
    var name: String
    var short_name: String
    var url: String
    var image: String?
    var images: [ImageTypes]?
    var primary: Bool
    var id: Int
    var score: Int
    var type: String
    var slug: String
}

struct ImageTypes: Codable {
    var large: String
    var huge: String
    var small: String
    var medium: String
}

struct Venue: Codable {
    var city: String
    var name: String
    var extended_address: String?
    var url: String
    var country: String
    var state: String
    var score: Double
    var postal_code: String
    var location: Coordinate
    var address: String?
    var id: Int
}

struct Coordinate: Codable {
    var lat: Double
    var lon: Double
}

struct Taxonomy: Codable {
    var parent_id: Int?
    var id: Int
    var name: String
}
