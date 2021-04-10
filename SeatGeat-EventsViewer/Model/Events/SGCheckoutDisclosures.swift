//
//  SGCheckoutDisclosures.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGCheckoutDisclosures: Codable {
    enum CodingKeys: String, CodingKey {
        case messages
    }

    var messages: [SGMessages]?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        messages = try container.decodeIfPresent([SGMessages].self, forKey: .messages)
    }
}
