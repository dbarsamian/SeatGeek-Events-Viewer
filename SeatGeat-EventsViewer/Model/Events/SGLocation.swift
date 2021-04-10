//
//  SGLocation.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGLocation: Codable {
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }

    var lat: Float?
    var lon: Float?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lat = try container.decodeIfPresent(Float.self, forKey: .lat)
        lon = try container.decodeIfPresent(Float.self, forKey: .lon)
    }
}
