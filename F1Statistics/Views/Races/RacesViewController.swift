//
//  RacesViewController.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import UIKit

final class RacesViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = RacesViewModel()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "F1 Races"

        setupTableView()
        setupActivityIndicator()
        bindViewModel()

        viewModel.fetchRaces()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "showRaceDetails",
              let destination = segue.destination as? RaceDetailsViewController,
              let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        
        destination.hidesBottomBarWhenPushed = true

        let selectedRace = viewModel.race(at: indexPath.row)

        destination.viewModel = RaceDetailsViewModel(race: selectedRace)
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }

    private func bindViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            guard let self else { return }

            switch state {
            case .loading:
                self.activityIndicator.startAnimating()

            case .success:
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()

            case .empty:
                self.activityIndicator.stopAnimating()
                self.showAlert(title: "Нет данных", message: "Список гонок пуст.")

            case .error(let message):
                self.activityIndicator.stopAnimating()
                self.showAlert(title: "Ошибка", message: message)
            }
        }
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

extension RacesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.numberOfRaces
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "RaceCell",
            for: indexPath
        ) as? RaceTableCellViewController else {
            return UITableViewCell()
        }

        let cellViewModel = viewModel.raceCellViewModel(at: indexPath.row)
        cell.configure(with: cellViewModel)

        return cell
    }
}
