//
//  Race.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import Foundation

struct Race: Codable {
    let season: String
    let round: String
    let raceName: String
    let circuit: Circuit
    let date: String
    let time: String?

    enum CodingKeys: String, CodingKey {
        case season
        case round
        case raceName
        case circuit = "Circuit"
        case date
        case time
    }
}

struct Circuit: Codable {
    let circuitId: String
    let circuitName: String
    let location: RaceLocation

    enum CodingKeys: String, CodingKey {
        case circuitId
        case circuitName
        case location = "Location"
    }
}

struct RaceLocation: Codable {
    let locality: String
    let country: String
}
