//
//  SGDivisions.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGDivisions: Codable {
    enum CodingKeys: String, CodingKey {
        case displayType = "display_type"
        case displayName = "display_name"
        case shortName = "short_name"
        case divisionLevel = "division_level"
        case slug
        case taxonomyId = "taxonomy_id"
    }

    var displayType: String?
    var displayName: String?
    var shortName: String?
    var divisionLevel: Int?
    var slug: String?
    var taxonomyId: Int?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        displayType = try container.decodeIfPresent(String.self, forKey: .displayType)
        displayName = try container.decodeIfPresent(String.self, forKey: .displayName)
        shortName = try container.decodeIfPresent(String.self, forKey: .shortName)
        divisionLevel = try container.decodeIfPresent(Int.self, forKey: .divisionLevel)
        slug = try container.decodeIfPresent(String.self, forKey: .slug)
        taxonomyId = try container.decodeIfPresent(Int.self, forKey: .taxonomyId)
    }
}
