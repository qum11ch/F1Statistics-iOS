//
//  FirebaseDriverDetailsService.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import Foundation
import FirebaseDatabase

final class FirebaseDriverDetailsService {

    private let database = Database.database().reference()

    func fetchDriverDetails(driverName: String) async throws -> DriverDetails {
        let snapshot = try await database
            .child("drivers")
            .child(driverName)
            .getData()

        guard let value = snapshot.value as? [String: Any] else {
            throw NSError(
                domain: "FirebaseDriverDetailsService",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "Данные о пилоте не найдены"]
            )
        }

        return DriverDetails(
            championshipsCount: value["championshipsCount"] as? String ?? "-",
            driverCountry: value["driverCountry"] as? String ?? "-",
            driverName: value["driverName"] as? String ?? driverName,
            driversCode: value["driversCode"] as? String ?? "-",
            driversTeam: value["driversTeam"] as? String ?? "-",
            firstEntry: value["firstEntry"] as? String ?? "-",
            lastEntry: value["lastEntry"] as? String ?? "-",
            permanentNumber: value["permanentNumber"] as? String ?? "-",
            polesCount: value["polesCount"] as? String ?? "-",
            totalPodiums: value["totalPodiums"] as? String ?? "-",
            totalPoints: value["totalPoints"] as? String ?? "-",
            totalWins: value["totalWins"] as? String ?? "-"
        )

    }
}
