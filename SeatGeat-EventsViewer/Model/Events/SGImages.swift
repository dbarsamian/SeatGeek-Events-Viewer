//
//  SGImages.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGImages: Codable {
    enum CodingKeys: String, CodingKey {
        case huge
    }

    var huge: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        huge = try container.decodeIfPresent(String.self, forKey: .huge)
    }
}
