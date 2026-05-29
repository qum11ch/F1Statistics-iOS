//
//  RaceViewModel.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import Foundation

enum ViewState {
    case loading
    case success
    case empty
    case error(String)
}

struct RaceCellViewModel {
    let raceName: String
    let raceLocation: String
    let raceRound: String
    let raceDay: String
    let raceMonth: String
    let raceCountry: String
}

final class RacesViewModel {

    private let raceAPIService = RaceAPIService()

    private(set) var races: [Race] = []

    var onStateChanged: ((ViewState) -> Void)?

    var numberOfRaces: Int {
        races.count
    }

    func fetchRaces() {
        onStateChanged?(.loading)

        Task {
            do {
                let fetchedRaces = try await raceAPIService.fetchRaces(season: "2026")
                self.races = fetchedRaces

                await MainActor.run {
                    self.onStateChanged?(fetchedRaces.isEmpty ? .empty : .success)
                }
            } catch {
                await MainActor.run {
                    self.onStateChanged?(.error(error.localizedDescription))
                }
            }
        }
    }
    
    func race(at index: Int) -> Race {
        races[index]
    }

    func raceCellViewModel(at index: Int) -> RaceCellViewModel {
        let race = races[index]
        let date = parseRaceDate(race.date)

        return RaceCellViewModel(
            raceName: race.raceName,
            raceLocation: race.circuit.circuitName,
            raceRound: "ROUND \(race.round)",
            raceDay: date.day,
            raceMonth: date.month,
            raceCountry: race.circuit.location.country
        )
    }

    private func parseRaceDate(_ dateString: String) -> (day: String, month: String) {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "en_US")
        outputFormatter.dateFormat = "MMM"

        guard let date = inputFormatter.date(from: dateString) else {
            return ("-", "-")
        }

        let day = String(Calendar.current.component(.day, from: date))
        let month = outputFormatter.string(from: date).uppercased()

        return (day, month)
    }
}
