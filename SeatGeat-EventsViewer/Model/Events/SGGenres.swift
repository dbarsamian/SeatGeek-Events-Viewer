//
//  SGGenres.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGGenres: Codable {
    enum CodingKeys: String, CodingKey {
        case primary
        case name
        case documentSource = "document_source"
        case image
        case id
        case images
        case slug
    }

    var primary: Bool?
    var name: String?
    var documentSource: SGDocumentSource?
    var image: String?
    var id: Int?
    var images: SGImages?
    var slug: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        primary = try container.decodeIfPresent(Bool.self, forKey: .primary)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        documentSource = try container.decodeIfPresent(SGDocumentSource.self, forKey: .documentSource)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        images = try container.decodeIfPresent(SGImages.self, forKey: .images)
        slug = try container.decodeIfPresent(String.self, forKey: .slug)
    }
}
