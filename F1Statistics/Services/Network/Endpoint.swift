//
//  Endpoint.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import Foundation

enum Endpoint {
    static let baseURL = "https://api.jolpi.ca/ergast/f1"

    case races(season: String)
    case driverStandings(season: String)

    var url: URL? {
        switch self {
        case .races(let season):
            return URL(string: "\(Endpoint.baseURL)/\(season)/races.json")
        case .driverStandings(let season):
            return URL(string: "\(Endpoint.baseURL)/\(season)/driverStandings.json")
        }
    }
}
