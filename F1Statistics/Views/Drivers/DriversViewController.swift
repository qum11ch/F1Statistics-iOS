//
//  DriversViewController.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import UIKit

final class DriversViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = DriversViewModel()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Drivers"

        setupTableView()
        setupActivityIndicator()
        bindViewModel()

        viewModel.fetchDrivers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard segue.identifier == "showDriverDetails",
              let destination = segue.destination as? DriverDetailsViewController,
              let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        
        destination.hidesBottomBarWhenPushed = true

        let standing = viewModel.standing(at: indexPath.row)
        let driver = standing.Driver

        destination.viewModel = DriverDetailsViewModel(
            driverName: driver.fullName,
            driverCode: driver.code ?? "",
            season: "2026"
        )
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
                self.showAlert(title: "Нет данных", message: "Список пилотов пуст.")

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

extension DriversViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.numberOfDrivers
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "DriverCell",
            for: indexPath
        ) as? DriverTableCellViewController else {
            return UITableViewCell()
        }
        
        let cellViewModel = viewModel.driverCellViewModel(at: indexPath.row)
        cell.configure(with: cellViewModel)

        return cell
    }
}
