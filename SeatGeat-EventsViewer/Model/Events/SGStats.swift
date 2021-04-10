//
//  SGStats.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGStats: Codable {
    enum CodingKeys: String, CodingKey {
        case lowestPrice = "lowest_price"
        case highestPrice = "highest_price"
        case lowestSgBasePrice = "lowest_sg_base_price"
        case visibleListingCount = "visible_listing_count"
        case dqBucketCounts = "dq_bucket_counts"
        case medianPrice = "median_price"
        case lowestSgBasePriceGoodDeals = "lowest_sg_base_price_good_deals"
        case lowestPriceGoodDeals = "lowest_price_good_deals"
        case averagePrice = "average_price"
        case listingCount = "listing_count"
    }

    var lowestPrice: Int?
    var highestPrice: Int?
    var lowestSgBasePrice: Int?
    var visibleListingCount: Int?
    var dqBucketCounts: [Int]?
    var medianPrice: Int?
    var lowestSgBasePriceGoodDeals: Int?
    var lowestPriceGoodDeals: Int?
    var averagePrice: Int?
    var listingCount: Int?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lowestPrice = try container.decodeIfPresent(Int.self, forKey: .lowestPrice)
        highestPrice = try container.decodeIfPresent(Int.self, forKey: .highestPrice)
        lowestSgBasePrice = try container.decodeIfPresent(Int.self, forKey: .lowestSgBasePrice)
        visibleListingCount = try container.decodeIfPresent(Int.self, forKey: .visibleListingCount)
        dqBucketCounts = try container.decodeIfPresent([Int].self, forKey: .dqBucketCounts)
        medianPrice = try container.decodeIfPresent(Int.self, forKey: .medianPrice)
        lowestSgBasePriceGoodDeals = try container.decodeIfPresent(Int.self, forKey: .lowestSgBasePriceGoodDeals)
        lowestPriceGoodDeals = try container.decodeIfPresent(Int.self, forKey: .lowestPriceGoodDeals)
        averagePrice = try container.decodeIfPresent(Int.self, forKey: .averagePrice)
        listingCount = try container.decodeIfPresent(Int.self, forKey: .listingCount)
    }
}
