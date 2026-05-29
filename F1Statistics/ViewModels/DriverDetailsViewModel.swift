//
//  DriverDetailsViewModel.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import Foundation

final class DriverDetailsViewModel {

    private let driverName: String
    private let detailsService = FirebaseDriverDetailsService()
    private let storageService = FirebaseStorageService()
    
    private let driverCode: String
    private let season: String

    private(set) var details: DriverDetails?
    private(set) var imageURL: URL?

    var onStateChanged: ((ViewState) -> Void)?
    var onImageURLLoaded: (() -> Void)?

    init(
        driverName: String,
        driverCode: String,
        season: String
    ) {
        self.driverName = driverName
        self.driverCode = driverCode
        self.season = season
    }
    
    private var nameParts: [String] {
        details?.driverName.components(separatedBy: " ") ?? []
    }

    var firstName: String {

        guard let driverName = details?.driverName else {
            return ""
        }

        switch driverName {
        case "Andrea Kimi Antonelli":
            return "Kimi"

        default:
            return nameParts.first ?? ""
        }
    }

    var lastName: String {

        guard let driverName = details?.driverName else {
            return ""
        }

        switch driverName {
        case "Andrea Kimi Antonelli":
            return "Antonelli"

        default:
            return nameParts.last ?? ""
        }
    }

    var title: String {
        driverName
    }

    func fetchDriverDetails() {
        Task {
            await MainActor.run {
                self.onStateChanged?(.loading)
            }

            do {
                let details = try await detailsService.fetchDriverDetails(
                    driverName: driverName
                )

                self.details = details

                await MainActor.run {
                    self.onStateChanged?(.success)
                }

            } catch {
                await MainActor.run {
                    self.onStateChanged?(.error(error.localizedDescription))
                }
            }
        }
    }

    func fetchDriverImageURL() {
        Task {
            do {

                let url = try await storageService.fetchDriverImageURL(
                    driverCode: driverCode,
                    season: season
                )

                self.imageURL = url

                await MainActor.run {
                    self.onImageURLLoaded?()
                }

            } catch {
                print("Driver image URL error:", error.localizedDescription)
            }
        }
    }
}
