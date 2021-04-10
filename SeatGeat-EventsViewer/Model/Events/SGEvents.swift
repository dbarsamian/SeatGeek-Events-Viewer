//
//  SGEvents.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGEvents: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case score
        case isOpen = "is_open"
        case venue
        case domainInformation = "domain_information"
        case links
        case performers
        case accessMethod = "access_method"
        case createdAt = "created_at"
        case datetimeTbd = "datetime_tbd"
        case type
        case shortTitle = "short_title"
        case datetimeUtc = "datetime_utc"
        case visibleUntilUtc = "visible_until_utc"
        case announcements
        case generalAdmission = "general_admission"
        case timeTbd = "time_tbd"
        case title
        case url
        case status
        case stats
        case datetimeLocal = "datetime_local"
        case themes
        case dateTbd = "date_tbd"
        case conditional
        case descriptionValue = "description"
        case announceDate = "announce_date"
        case popularity
        case taxonomies
    }

    var id: Int?
    var score: Float?
    var isOpen: Bool?
    var venue: SGVenue?
    var domainInformation: [String]?
    var links: [String]?
    var performers: [SGPerformers]?
    var accessMethod: SGAccessMethod?
    var createdAt: String?
    var datetimeTbd: Bool?
    var type: String?
    var shortTitle: String?
    var datetimeUtc: String?
    var visibleUntilUtc: String?
    var announcements: SGAnnouncements?
    var generalAdmission: Bool?
    var timeTbd: Bool?
    var title: String?
    var url: String?
    var status: String?
    var stats: SGStats?
    var datetimeLocal: String?
    var themes: [String]?
    var dateTbd: Bool?
    var conditional: Bool?
    var descriptionValue: String?
    var announceDate: String?
    var popularity: Float?
    var taxonomies: [SGTaxonomies]?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        score = try container.decodeIfPresent(Float.self, forKey: .score)
        isOpen = try container.decodeIfPresent(Bool.self, forKey: .isOpen)
        venue = try container.decodeIfPresent(SGVenue.self, forKey: .venue)
        domainInformation = try container.decodeIfPresent([String].self, forKey: .domainInformation)
        links = try container.decodeIfPresent([String].self, forKey: .links)
        performers = try container.decodeIfPresent([SGPerformers].self, forKey: .performers)
        accessMethod = try container.decodeIfPresent(SGAccessMethod.self, forKey: .accessMethod)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        datetimeTbd = try container.decodeIfPresent(Bool.self, forKey: .datetimeTbd)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        shortTitle = try container.decodeIfPresent(String.self, forKey: .shortTitle)
        datetimeUtc = try container.decodeIfPresent(String.self, forKey: .datetimeUtc)
        visibleUntilUtc = try container.decodeIfPresent(String.self, forKey: .visibleUntilUtc)
        announcements = try container.decodeIfPresent(SGAnnouncements.self, forKey: .announcements)
        generalAdmission = try container.decodeIfPresent(Bool.self, forKey: .generalAdmission)
        timeTbd = try container.decodeIfPresent(Bool.self, forKey: .timeTbd)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        stats = try container.decodeIfPresent(SGStats.self, forKey: .stats)
        datetimeLocal = try container.decodeIfPresent(String.self, forKey: .datetimeLocal)
        themes = try container.decodeIfPresent([String].self, forKey: .themes)
        dateTbd = try container.decodeIfPresent(Bool.self, forKey: .dateTbd)
        conditional = try container.decodeIfPresent(Bool.self, forKey: .conditional)
        descriptionValue = try container.decodeIfPresent(String.self, forKey: .descriptionValue)
        announceDate = try container.decodeIfPresent(String.self, forKey: .announceDate)
        popularity = try container.decodeIfPresent(Float.self, forKey: .popularity)
        taxonomies = try container.decodeIfPresent([SGTaxonomies].self, forKey: .taxonomies)
    }
}
