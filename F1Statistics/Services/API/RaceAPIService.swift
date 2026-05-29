//
//  RaceAPIService.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import Foundation

struct RacesResponse: Codable {
    let MRData: RaceMRData
}

struct RaceMRData: Codable {
    let RaceTable: RaceTable
}

struct RaceTable: Codable {
    let Races: [Race]
}

final class RaceAPIService {

    func fetchRaces(season: String) async throws -> [Race] {
        guard let url = Endpoint.races(season: season).url else {
            throw URLError(.badURL)
        }

        let response: RacesResponse = try await NetworkManager.shared.request(url)
        return response.MRData.RaceTable.Races
    }
}
