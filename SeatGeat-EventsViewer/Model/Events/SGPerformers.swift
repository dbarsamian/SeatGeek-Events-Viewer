//
//  SGPerformers.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGPerformers: Codable {
    enum CodingKeys: String, CodingKey {
        case imageAttribution = "image_attribution"
        case awayTeam = "away_team"
        case name
        case url
        case image
        case homeTeam = "home_team"
        case id
        case taxonomies
        case numUpcomingEvents = "num_upcoming_events"
        case slug
        case homeVenueId = "home_venue_id"
        case popularity
        case stats
        case type
        case colors
        case shortName = "short_name"
        case genres
        case divisions
        case images
        case primary
        case hasUpcomingEvents = "has_upcoming_events"
        case imageLicense = "image_license"
        case score
        case location
    }

    var imageAttribution: String?
    var awayTeam: Bool?
    var name: String?
    var url: String?
    var image: String?
    var homeTeam: Bool?
    var id: Int?
    var taxonomies: [SGTaxonomies]?
    var numUpcomingEvents: Int?
    var slug: String?
    var homeVenueId: Int?
    var popularity: Int?
    var stats: SGStats?
    var type: String?
    var colors: SGColors?
    var shortName: String?
    var genres: [SGGenres]?
    var divisions: [SGDivisions]?
    var images: SGImages?
    var primary: Bool?
    var hasUpcomingEvents: Bool?
    var imageLicense: String?
    var score: Float?
    var location: SGLocation?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageAttribution = try container.decodeIfPresent(String.self, forKey: .imageAttribution)
        awayTeam = try container.decodeIfPresent(Bool.self, forKey: .awayTeam)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        homeTeam = try container.decodeIfPresent(Bool.self, forKey: .homeTeam)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        taxonomies = try container.decodeIfPresent([SGTaxonomies].self, forKey: .taxonomies)
        numUpcomingEvents = try container.decodeIfPresent(Int.self, forKey: .numUpcomingEvents)
        slug = try container.decodeIfPresent(String.self, forKey: .slug)
        homeVenueId = try container.decodeIfPresent(Int.self, forKey: .homeVenueId)
        popularity = try container.decodeIfPresent(Int.self, forKey: .popularity)
        stats = try container.decodeIfPresent(SGStats.self, forKey: .stats)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        colors = try container.decodeIfPresent(SGColors.self, forKey: .colors)
        shortName = try container.decodeIfPresent(String.self, forKey: .shortName)
        genres = try container.decodeIfPresent([SGGenres].self, forKey: .genres)
        divisions = try container.decodeIfPresent([SGDivisions].self, forKey: .divisions)
        images = try container.decodeIfPresent(SGImages.self, forKey: .images)
        primary = try container.decodeIfPresent(Bool.self, forKey: .primary)
        hasUpcomingEvents = try container.decodeIfPresent(Bool.self, forKey: .hasUpcomingEvents)
        imageLicense = try container.decodeIfPresent(String.self, forKey: .imageLicense)
        score = try container.decodeIfPresent(Float.self, forKey: .score)
        location = try container.decodeIfPresent(SGLocation.self, forKey: .location)
    }
}
