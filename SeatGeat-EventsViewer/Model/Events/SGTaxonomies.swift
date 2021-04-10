//
//  SGTaxonomies.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGTaxonomies: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case parentId = "parent_id"
        case rank
    }

    var name: String?
    var id: Int?
    var parentId: Int?
    var rank: Int?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        parentId = try container.decodeIfPresent(Int.self, forKey: .parentId)
        rank = try container.decodeIfPresent(Int.self, forKey: .rank)
    }
}
