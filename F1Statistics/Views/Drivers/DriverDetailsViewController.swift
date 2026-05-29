//
//  DriverDetailsViewController.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import UIKit
import Kingfisher

final class DriverDetailsViewController: UIViewController {

    @IBOutlet private weak var driverImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var surnameLabel: UILabel!
    @IBOutlet private weak var teamLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var championshipsLabel: UILabel!
    @IBOutlet private weak var winsLabel: UILabel!
    @IBOutlet private weak var podiumsLabel: UILabel!
    @IBOutlet private weak var pointsLabel: UILabel!
    @IBOutlet private weak var firstEntryLabel: UILabel!
    @IBOutlet private weak var lastEntryLabel: UILabel!

    var viewModel: DriverDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title

        setupImageView()
        bindViewModel()

        viewModel.fetchDriverDetails()
        viewModel.fetchDriverImageURL()
    }

    private func setupImageView() {
        driverImageView.contentMode = .scaleAspectFill
        driverImageView.clipsToBounds = true
        driverImageView.layer.cornerRadius = 12
    }

    private func bindViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            guard let self else { return }

            switch state {
            case .loading:
                break

            case .success:
                self.updateUI()

            case .empty:
                break

            case .error(let message):
                self.showAlert(title: "Ошибка", message: message)
            }
        }

        viewModel.onImageURLLoaded = { [weak self] in
            guard let self,
                  let url = self.viewModel.imageURL else {
                return
            }

            self.driverImageView.kf.setImage(with: url)
        }
    }

    private func updateUI() {
        guard let details = viewModel.details else { return }

        nameLabel.text = viewModel.firstName
        surnameLabel.text = viewModel.lastName
        
        teamLabel.text = details.driversTeam
        numberLabel.text = details.permanentNumber
        championshipsLabel.text = "Championships Titles: \(details.championshipsCount)"
        winsLabel.text = "Wins: \(details.totalWins)"
        podiumsLabel.text = "Podiums: \(details.totalPodiums)"
        pointsLabel.text = "Points: \(details.totalPoints)"
        firstEntryLabel.text = "First entry: \(details.firstEntry)"
        lastEntryLabel.text = "Last entry: \(details.lastEntry)"
    }
    

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }
}
