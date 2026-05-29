//
//  DriversViewModel.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import Foundation

struct DriverCellViewModel {
    let driverPosition: String
    let driverFullName: String
    let driverPoints: String
    let driverTeam: String
}

final class DriversViewModel {

    private let driverAPIService = DriverAPIService()

    private(set) var standings: [DriverStanding] = []

    var onStateChanged: ((ViewState) -> Void)?

    func fetchDrivers() {
        Task {
            await MainActor.run {
                self.onStateChanged?(.loading)
            }

            do {
                let fetchedStandings = try await driverAPIService.fetchDriverStandings(season: "2026")
                self.standings = fetchedStandings

                await MainActor.run {
                    self.onStateChanged?(fetchedStandings.isEmpty ? .empty : .success)
                }
            } catch {
                await MainActor.run {
                    self.onStateChanged?(.error(error.localizedDescription))
                }
            }
        }
    }

    func standing(at index: Int) -> DriverStanding {
        standings[index]
    }

    var numberOfDrivers: Int {
        standings.count
    }
    
    func driverCellViewModel(at index: Int) -> DriverCellViewModel {
        let standing = standings[index]
        let driver = standing.Driver
        let constructor = standing.Constructors.first?.name ?? "-"

        return DriverCellViewModel(
            driverPosition: standing.position,
            driverFullName: driver.fullName,
            driverPoints: "\(standing.points) PTS",
            driverTeam: constructor
        )
    }
}
