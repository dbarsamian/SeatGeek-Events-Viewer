//
//  SGEventsData.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGEventsData: Codable {
    enum CodingKeys: String, CodingKey {
        case meta
        case inHand = "in_hand"
        case events
    }

    var meta: SGMeta?
    var inHand: [String: String]?
    var events: [SGEvent]?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        meta = try container.decodeIfPresent(SGMeta.self, forKey: .meta)
        inHand = try container.decodeIfPresent([String: String].self, forKey: .inHand)
        events = try container.decodeIfPresent([SGEvent].self, forKey: .events)
    }
}
