//
//  NetworkManager.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import Foundation

final class NetworkManager {

    static let shared = NetworkManager()

    private init() {}

    func request<T: Decodable>(_ url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
