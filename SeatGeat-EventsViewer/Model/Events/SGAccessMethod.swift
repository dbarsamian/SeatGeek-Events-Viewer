//
//  SGAccessMethod.swift
//
//  Created by David Barsamian on 4/9/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct SGAccessMethod: Codable {
    enum CodingKeys: String, CodingKey {
        case employeeOnly = "employee_only"
        case createdAt = "created_at"
        case method
    }

    var employeeOnly: Bool?
    var createdAt: String?
    var method: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        employeeOnly = try container.decodeIfPresent(Bool.self, forKey: .employeeOnly)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        method = try container.decodeIfPresent(String.self, forKey: .method)
    }
}
