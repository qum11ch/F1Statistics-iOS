import Foundation
import FirebaseStorage

final class RaceDetailsViewModel {

    private let race: Race
    private let storageService = FirebaseStorageService()
    
    private(set) var imageURL: URL?
    
    var onImageURLLoaded: (() -> Void)?

    init(race: Race) {
        self.race = race
    }

    var raceName: String {
        race.raceName
    }

    var circuitId: String {
        race.circuit.circuitId
    }

    var circuitName: String {
        race.circuit.circuitName
    }

    var country: String {
        race.circuit.location.country
    }

    var locality: String {
        race.circuit.location.locality
    }

    var date: String {
        race.date
    }

    var time: String {
        race.time ?? "Unknown"
    }

    var round: String {
        race.round
    }

    var season: String {
        race.season
    }
    
    func fetchTrackImageURL() {
        Task {
            do {
                let url = try await storageService.fetchTrackImageURL(
                    circuitId: circuitId
                )

                self.imageURL = url

                await MainActor.run {
                    self.onImageURLLoaded?()
                }

            } catch {
                print("Track image URL error:", error.localizedDescription)
            }
        }
    }
}
