//
//  SGMeta.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGMeta: Codable {
    enum CodingKeys: String, CodingKey {
        case perPage = "per_page"
        case took
        case total
        case page
    }

    var perPage: Int?
    var took: Int?
    var total: Int?
    var page: Int?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        perPage = try container.decodeIfPresent(Int.self, forKey: .perPage)
        took = try container.decodeIfPresent(Int.self, forKey: .took)
        total = try container.decodeIfPresent(Int.self, forKey: .total)
        page = try container.decodeIfPresent(Int.self, forKey: .page)
    }
}
