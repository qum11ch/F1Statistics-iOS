//
//  FirebaseStorageService.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import FirebaseStorage
import Foundation

final class FirebaseStorageService {

    private let storage = Storage.storage()

    func fetchTrackImageURL(
        circuitId: String
    ) async throws -> URL {

        let reference = storage
            .reference()
            .child("circuits/\(circuitId).png")

        return try await reference.downloadURL()
    }
    
    func fetchDriverImageURL(
        driverCode: String,
        season: String
    ) async throws -> URL {

        let fileName = "\(driverCode.lowercased())_\(season).png"

        let reference = storage
            .reference()
            .child("drivers/\(fileName)")

        return try await reference.downloadURL()
    }
}
