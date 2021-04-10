//
//  SGAnnouncements.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGAnnouncements: Codable {
    enum CodingKeys: String, CodingKey {
        case checkoutDisclosures = "checkout_disclosures"
    }

    var checkoutDisclosures: SGCheckoutDisclosures?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        checkoutDisclosures = try container.decodeIfPresent(SGCheckoutDisclosures.self, forKey: .checkoutDisclosures)
    }
}
