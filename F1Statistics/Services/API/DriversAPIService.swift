//
//  DriversAPIService.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import Foundation

final class DriverAPIService {

    func fetchDriverStandings(season: String) async throws -> [DriverStanding] {
        guard let url = Endpoint.driverStandings(season: season).url else {
            throw URLError(.badURL)
        }

        let response: DriverStandingsResponse = try await NetworkManager.shared.request(url)

        return response
            .MRData
            .StandingsTable
            .StandingsLists
            .first?
            .DriverStandings ?? []
    }
}
