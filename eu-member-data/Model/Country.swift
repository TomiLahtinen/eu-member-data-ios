// To parse the JSON, add this file to your project and do:
//
//   let country = Country.from(json: jsonString)!

import Foundation

typealias Country = OtherCountry

struct OtherCountry: Codable {
    let countries: [OtherOtherCountry]
}

struct OtherOtherCountry: Codable {
    let currency: String
    let capital: Capital
    let area: Int
    let code: String
    let name: Name
    let joined: Joined
    let population: Population
}

struct Capital: Codable {
    let coordinate: Coordinate
    let name: Name
}

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
}

struct Name: Codable {
    let et: String
    let lt: String?
    let de: String
    let cs: String
    let bg: String
    let da: String
    let en: String
    let el: String
    let es: String?
    let gr: String?
    let fr: String
    let fi: String
    let ga: String?
    let hu: String
    let hr: String
    let it: String
    let pl: String
    let mt: String
    let lv: String
    let nl: String
    let ro: String
    let sl: String
    let pt: String
    let sk: String
    let sv: String
}

struct Joined: Codable {
    let schengen: String
    let euro: String
    let union: String
}

struct Population: Codable {
    let population: Int
    let year: Int
}

// Serialization extensions

extension OtherCountry {
    static func from(json: String, using encoding: String.Encoding = .utf8) -> OtherCountry? {
        guard let data = json.data(using: encoding) else { return nil }
        return OtherCountry.from(data: data)
    }

    static func from(data: Data) -> OtherCountry? {
        let decoder = JSONDecoder()
        return try? decoder.decode(OtherCountry.self, from: data)
    }

    var jsonData: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }

    var jsonString: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Capital {
    enum CodingKeys: String, CodingKey {
        case coordinate
        case name
    }
}

extension Coordinate {
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}

extension Joined {
    enum CodingKeys: String, CodingKey {
        case schengen
        case euro
        case union
    }
}

extension Name {
    enum CodingKeys: String, CodingKey {
        case et
        case lt
        case de
        case cs
        case bg
        case da
        case en
        case el
        case es
        case gr
        case fr
        case fi
        case ga
        case hu
        case hr
        case it
        case pl
        case mt
        case lv
        case nl
        case ro
        case sl
        case pt
        case sk
        case sv
    }
}

extension OtherCountry {
    enum CodingKeys: String, CodingKey {
        case countries
    }
}

extension OtherOtherCountry {
    enum CodingKeys: String, CodingKey {
        case currency
        case capital
        case area
        case code
        case name
        case joined
        case population
    }
}

extension Population {
    enum CodingKeys: String, CodingKey {
        case population
        case year
    }
}

// Helpers

class JSONNull: Codable {
    public init() {
    }
    
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
