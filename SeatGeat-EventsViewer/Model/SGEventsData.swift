// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let sGEventsData = try? newJSONDecoder().decode(SGEventsData.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.sGEventsDataTask(with: url) { sGEventsData, response, error in
//     if let sGEventsData = sGEventsData {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - SGEventsData
struct SGEventsData: Codable {
    let events: [SGEvent]
    let meta: SGMeta
    let inHand: SGInHand
    
    enum CodingKeys: String, CodingKey {
        case events, meta
        case inHand = "in_hand"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sGEventTask(with: url) { sGEvent, response, error in
//     if let sGEvent = sGEvent {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SGEvent
struct SGEvent: Codable {
    let type: String
    let id: Int
    let datetimeUTC: SGDatetimeUTC
    let venue: SGVenue
    let datetimeTbd: Bool
    let performers: [SGPerformer]
    let isOpen: Bool
    let links: [JSONAny]
    let datetimeLocal: SGDatetimeLocal
    let timeTbd: Bool
    let shortTitle: String
    let visibleUntilUTC: SGVisibleUntilUTC
    let stats: SGEventStats
    let taxonomies: [SGTaxonomy]
    let url: String
    let score: Double
    let announceDate, createdAt: String
    let dateTbd: Bool
    let title: String
    let popularity: Double
    let eventDescription: String
    let status: SGStatus
    let accessMethod: SGAccessMethod?
    let eventPromotion: JSONNull?
    let announcements: SGInHand
    let conditional: Bool
    let enddatetimeUTC: JSONNull?
    let themes, domainInformation: [JSONAny]
    let generalAdmission: Bool?
    
    enum CodingKeys: String, CodingKey {
        case type, id
        case datetimeUTC = "datetime_utc"
        case venue
        case datetimeTbd = "datetime_tbd"
        case performers
        case isOpen = "is_open"
        case links
        case datetimeLocal = "datetime_local"
        case timeTbd = "time_tbd"
        case shortTitle = "short_title"
        case visibleUntilUTC = "visible_until_utc"
        case stats, taxonomies, url, score
        case announceDate = "announce_date"
        case createdAt = "created_at"
        case dateTbd = "date_tbd"
        case title, popularity
        case eventDescription = "description"
        case status
        case accessMethod = "access_method"
        case eventPromotion = "event_promotion"
        case announcements, conditional
        case enddatetimeUTC = "enddatetime_utc"
        case themes
        case domainInformation = "domain_information"
        case generalAdmission = "general_admission"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sGAccessMethodTask(with: url) { sGAccessMethod, response, error in
//     if let sGAccessMethod = sGAccessMethod {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SGAccessMethod
struct SGAccessMethod: Codable {
    let method: String
    let createdAt: Date
    let employeeOnly: Bool
    
    enum CodingKeys: String, CodingKey {
        case method
        case createdAt = "created_at"
        case employeeOnly = "employee_only"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sGInHandTask(with: url) { sGInHand, response, error in
//     if let sGInHand = sGInHand {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SGInHand
struct SGInHand: Codable {
}

enum SGDatetimeLocal: String, Codable {
    case the20210409T033000 = "2021-04-09T03:30:00"
}

enum SGDatetimeUTC: String, Codable {
    case the20210409T073000 = "2021-04-09T07:30:00"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sGPerformerTask(with: url) { sGPerformer, response, error in
//     if let sGPerformer = sGPerformer {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SGPerformer
struct SGPerformer: Codable {
    let type, name: String
    let image: String
    let id: Int
    let images: SGPerformerImages
    let divisions: JSONNull?
    let hasUpcomingEvents: Bool
    let primary: Bool?
    let stats: SGPerformerStats
    let taxonomies: [SGTaxonomy]
    let imageAttribution: String?
    let url: String
    let score: Double
    let slug: String
    let homeVenueID: Int?
    let shortName: String
    let numUpcomingEvents: Int
    let colors: JSONNull?
    let imageLicense: String?
    let popularity: Int
    let location: SGLocation?
    let genres: [SGGenre]?
    let homeTeam, awayTeam: Bool?
    
    enum CodingKeys: String, CodingKey {
        case type, name, image, id, images, divisions
        case hasUpcomingEvents = "has_upcoming_events"
        case primary, stats, taxonomies
        case imageAttribution = "image_attribution"
        case url, score, slug
        case homeVenueID = "home_venue_id"
        case shortName = "short_name"
        case numUpcomingEvents = "num_upcoming_events"
        case colors
        case imageLicense = "image_license"
        case popularity, location, genres
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sGGenreTask(with: url) { sGGenre, response, error in
//     if let sGGenre = sGGenre {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SGGenre
struct SGGenre: Codable {
    let id: Int
    let name, slug: String
    let primary: Bool
    let images: SGGenreImages
    let image: String
    let documentSource: SGDocumentSource
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug, primary, images, image
        case documentSource = "document_source"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sGDocumentSourceTask(with: url) { sGDocumentSource, response, error in
//     if let sGDocumentSource = sGDocumentSource {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SGDocumentSource
struct SGDocumentSource: Codable {
    let sourceType: SGSourceType
    let generationType: SGGenerationType
    
    enum CodingKeys: String, CodingKey {
        case sourceType = "source_type"
        case generationType = "generation_type"
    }
}

enum SGGenerationType: String, Codable {
    case full = "FULL"
}

enum SGSourceType: String, Codable {
    case elastic = "ELASTIC"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sGGenreImagesTask(with: url) { sGGenreImages, response, error in
//     if let sGGenreImages = sGGenreImages {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SGGenreImages
struct SGGenreImages: Codable {
    let the1200X525, the1200X627, the136X136, the500_700: String
    let the800X320, banner, block, criteo130_160: String
    let criteo170_235, criteo205_100, criteo400_300, fb100X72: String
    let fb600_315, huge, ipadEventModal, ipadHeader: String
    let ipadMiniExplore, mongo, squareMid, triggitFbAd: String
    
    enum CodingKeys: String, CodingKey {
        case the1200X525 = "1200x525"
        case the1200X627 = "1200x627"
        case the136X136 = "136x136"
        case the500_700 = "500_700"
        case the800X320 = "800x320"
        case banner, block
        case criteo130_160 = "criteo_130_160"
        case criteo170_235 = "criteo_170_235"
        case criteo205_100 = "criteo_205_100"
        case criteo400_300 = "criteo_400_300"
        case fb100X72 = "fb_100x72"
        case fb600_315 = "fb_600_315"
        case huge
        case ipadEventModal = "ipad_event_modal"
        case ipadHeader = "ipad_header"
        case ipadMiniExplore = "ipad_mini_explore"
        case mongo
        case squareMid = "square_mid"
        case triggitFbAd = "triggit_fb_ad"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sGPerformerImagesTask(with: url) { sGPerformerImages, response, error in
//     if let sGPerformerImages = sGPerformerImages {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SGPerformerImages
struct SGPerformerImages: Codable {
    let huge: String
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sGLocationTask(with: url) { sGLocation, response, error in
//     if let sGLocation = sGLocation {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SGLocation
struct SGLocation: Codable {
    let lat, lon: Double
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sGPerformerStatsTask(with: url) { sGPerformerStats, response, error in
//     if let sGPerformerStats = sGPerformerStats {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SGPerformerStats
struct SGPerformerStats: Codable {
    let eventCount: Int
    
    enum CodingKeys: String, CodingKey {
        case eventCount = "event_count"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sGTaxonomyTask(with: url) { sGTaxonomy, response, error in
//     if let sGTaxonomy = sGTaxonomy {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SGTaxonomy
struct SGTaxonomy: Codable {
    let id: Int
    let name: String
    let parentID: Int?
    let documentSource: SGDocumentSource?
    let rank: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case parentID = "parent_id"
        case documentSource = "document_source"
        case rank
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sGEventStatsTask(with: url) { sGEventStats, response, error in
//     if let sGEventStats = sGEventStats {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SGEventStats
struct SGEventStats: Codable {
    let listingCount, averagePrice, lowestPriceGoodDeals, lowestPrice: JSONNull?
    let highestPrice, visibleListingCount, dqBucketCounts, medianPrice: JSONNull?
    let lowestSgBasePrice, lowestSgBasePriceGoodDeals: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case listingCount = "listing_count"
        case averagePrice = "average_price"
        case lowestPriceGoodDeals = "lowest_price_good_deals"
        case lowestPrice = "lowest_price"
        case highestPrice = "highest_price"
        case visibleListingCount = "visible_listing_count"
        case dqBucketCounts = "dq_bucket_counts"
        case medianPrice = "median_price"
        case lowestSgBasePrice = "lowest_sg_base_price"
        case lowestSgBasePriceGoodDeals = "lowest_sg_base_price_good_deals"
    }
}

enum SGStatus: String, Codable {
    case normal = "normal"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sGVenueTask(with: url) { sGVenue, response, error in
//     if let sGVenue = sGVenue {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SGVenue
struct SGVenue: Codable {
    let state, nameV2, postalCode, name: String
    let links: [JSONAny]
    let timezone: SGTimezone
    let url: String
    let score: Double
    let location: SGLocation
    let address: String
    let country: SGCountry
    let hasUpcomingEvents: Bool
    let numUpcomingEvents: Int
    let city, slug, extendedAddress: String
    let id, popularity: Int
    let accessMethod: SGAccessMethod?
    let metroCode, capacity: Int
    let displayLocation: String
    
    enum CodingKeys: String, CodingKey {
        case state
        case nameV2 = "name_v2"
        case postalCode = "postal_code"
        case name, links, timezone, url, score, location, address, country
        case hasUpcomingEvents = "has_upcoming_events"
        case numUpcomingEvents = "num_upcoming_events"
        case city, slug
        case extendedAddress = "extended_address"
        case id, popularity
        case accessMethod = "access_method"
        case metroCode = "metro_code"
        case capacity
        case displayLocation = "display_location"
    }
}

enum SGCountry: String, Codable {
    case us = "US"
}

enum SGTimezone: String, Codable {
    case americaDetroit = "America/Detroit"
    case americaKentuckyLouisville = "America/Kentucky/Louisville"
    case americaNewYork = "America/New_York"
}

enum SGVisibleUntilUTC: String, Codable {
    case the20210410T040000 = "2021-04-10T04:00:00"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sGMetaTask(with: url) { sGMeta, response, error in
//     if let sGMeta = sGMeta {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SGMeta
struct SGMeta: Codable {
    let total, took, page, perPage: Int
    let geolocation: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case total, took, page
        case perPage = "per_page"
        case geolocation
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func sGEventsDataTask(with url: URL, completionHandler: @escaping (SGEventsData?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public func hash(into hasher: inout Hasher) {
        // No-op
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
