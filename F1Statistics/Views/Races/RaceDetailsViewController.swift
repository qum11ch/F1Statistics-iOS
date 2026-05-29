//
//  RaceDetailsViewController.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 28.05.2026.
//

import Kingfisher
import UIKit

final class RaceDetailsViewController: UIViewController {
    
    @IBOutlet private weak var raceNameLabel: UILabel!
    @IBOutlet private weak var circuitLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var roundLabel: UILabel!
    
    @IBOutlet weak var trackImage: UIImageView!
    
    var viewModel: RaceDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidesBottomBarWhenPushed = true
        
        setupUI()
        bindViewModel()
        viewModel.fetchTrackImageURL()
    }
    
    private func setupUI() {
        title = viewModel.raceName
        
        raceNameLabel.text = viewModel.raceName
        circuitLabel.text = "\(viewModel.circuitName), \(viewModel.locality)"
        countryLabel.text = viewModel.country
        dateLabel.text = "\(viewModel.date) \(viewModel.time)"
        roundLabel.text = "Round \(viewModel.round)"
    }
    
    private func bindViewModel(){
        viewModel.onImageURLLoaded = { [weak self] in
            guard let self,
                      let url = self.viewModel.imageURL else{
                          return
                      }
            self.trackImage.kf.setImage(with: url)
        }
    }
}
