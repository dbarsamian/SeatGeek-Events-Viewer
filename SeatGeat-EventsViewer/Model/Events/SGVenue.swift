//
//  SGVenue.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGVenue: Codable {
    enum CodingKeys: String, CodingKey {
        case url
        case location
        case postalCode = "postal_code"
        case city
        case links
        case score
        case id
        case timezone
        case country
        case slug
        case displayLocation = "display_location"
        case capacity
        case extendedAddress = "extended_address"
        case nameV2 = "name_v2"
        case metroCode = "metro_code"
        case numUpcomingEvents = "num_upcoming_events"
        case state
        case name
        case hasUpcomingEvents = "has_upcoming_events"
        case popularity
        case accessMethod = "access_method"
        case address
    }

    var url: String?
    var location: SGLocation?
    var postalCode: String?
    var city: String?
    var links: [String]?
    var score: Float?
    var id: Int?
    var timezone: String?
    var country: String?
    var slug: String?
    var displayLocation: String?
    var capacity: Int?
    var extendedAddress: String?
    var nameV2: String?
    var metroCode: Int?
    var numUpcomingEvents: Int?
    var state: String?
    var name: String?
    var hasUpcomingEvents: Bool?
    var popularity: Int?
    var accessMethod: SGAccessMethod?
    var address: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        location = try container.decodeIfPresent(SGLocation.self, forKey: .location)
        postalCode = try container.decodeIfPresent(String.self, forKey: .postalCode)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        links = try container.decodeIfPresent([String].self, forKey: .links)
        score = try container.decodeIfPresent(Float.self, forKey: .score)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        slug = try container.decodeIfPresent(String.self, forKey: .slug)
        displayLocation = try container.decodeIfPresent(String.self, forKey: .displayLocation)
        capacity = try container.decodeIfPresent(Int.self, forKey: .capacity)
        extendedAddress = try container.decodeIfPresent(String.self, forKey: .extendedAddress)
        nameV2 = try container.decodeIfPresent(String.self, forKey: .nameV2)
        metroCode = try container.decodeIfPresent(Int.self, forKey: .metroCode)
        numUpcomingEvents = try container.decodeIfPresent(Int.self, forKey: .numUpcomingEvents)
        state = try container.decodeIfPresent(String.self, forKey: .state)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        hasUpcomingEvents = try container.decodeIfPresent(Bool.self, forKey: .hasUpcomingEvents)
        popularity = try container.decodeIfPresent(Int.self, forKey: .popularity)
        accessMethod = try container.decodeIfPresent(SGAccessMethod.self, forKey: .accessMethod)
        address = try container.decodeIfPresent(String.self, forKey: .address)
    }
}
