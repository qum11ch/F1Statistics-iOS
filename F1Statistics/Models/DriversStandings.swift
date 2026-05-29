//
//  Drivers.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import Foundation

struct Driver: Codable {
    let driverId: String
    let permanentNumber: String?
    let code: String?
    let givenName: String
    let familyName: String
    let dateOfBirth: String
    let nationality: String

    var fullName: String {
        "\(givenName) \(familyName)"
    }

    enum CodingKeys: String, CodingKey {
        case driverId
        case permanentNumber
        case code
        case givenName
        case familyName
        case dateOfBirth
        case nationality
    }
}
