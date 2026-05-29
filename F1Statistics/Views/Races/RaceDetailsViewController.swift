import UIKit

final class RaceDetailsViewController: UIViewController {

    @IBOutlet private weak var raceNameLabel: UILabel!
    @IBOutlet private weak var circuitLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var roundLabel: UILabel!

    var viewModel: RaceDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        title = viewModel.raceName

        raceNameLabel.text = viewModel.raceName
        circuitLabel.text = "\(viewModel.circuitName), \(viewModel.locality)"
        countryLabel.text = viewModel.country
        dateLabel.text = "\(viewModel.date) \(viewModel.time)"
        roundLabel.text = "Round \(viewModel.round)"
    }
}