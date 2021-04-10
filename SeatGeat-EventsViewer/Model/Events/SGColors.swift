//
//  SGColors.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGColors: Codable {
    enum CodingKeys: String, CodingKey {
        case primary
        case iconic
        case all
    }

    var primary: [String]?
    var iconic: String?
    var all: [String]?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        primary = try container.decodeIfPresent([String].self, forKey: .primary)
        iconic = try container.decodeIfPresent(String.self, forKey: .iconic)
        all = try container.decodeIfPresent([String].self, forKey: .all)
    }
}
