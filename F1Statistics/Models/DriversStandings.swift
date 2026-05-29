//
//  DriversStandings.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import Foundation

struct DriverStandingsResponse: Codable {
    let MRData: DriverStandingsMRData
}

struct DriverStandingsMRData: Codable {
    let StandingsTable: StandingsTable
}

struct StandingsTable: Codable {
    let StandingsLists: [StandingsList]
}

struct StandingsList: Codable {
    let season: String
    let round: String
    let DriverStandings: [DriverStanding]
}

struct DriverStanding: Codable {
    let position: String
    let positionText: String
    let points: String
    let wins: String
    let Driver: Driver
    let Constructors: [Constructor]
}

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
    
    var driverName: String {
        givenName
    }
    
    var surnameName: String {
        familyName
    }
}

struct Constructor: Codable {
    let constructorId: String
    let name: String
    let nationality: String
}
