//
//  SGDocumentSource.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGDocumentSource: Codable {
    enum CodingKeys: String, CodingKey {
        case generationType = "generation_type"
        case sourceType = "source_type"
    }

    var generationType: String?
    var sourceType: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        generationType = try container.decodeIfPresent(String.self, forKey: .generationType)
        sourceType = try container.decodeIfPresent(String.self, forKey: .sourceType)
    }
}
