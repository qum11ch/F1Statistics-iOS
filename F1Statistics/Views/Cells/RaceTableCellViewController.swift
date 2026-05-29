//
//  RaceTableCellViewController.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 29.05.2026.
//

import UIKit

class RaceTableCellViewController: UITableViewCell {
    
    @IBOutlet weak var raceRound: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var dayStart: UILabel!
    @IBOutlet weak var raceLocation: UILabel!
    @IBOutlet weak var raceName: UILabel!
    @IBOutlet weak var raceCountry: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with viewModel: RaceCellViewModel) {
            raceName.text = viewModel.raceName
            raceLocation.text = viewModel.raceLocation
            raceRound.text = viewModel.raceRound
            dayStart.text = viewModel.raceDay
            month.text = viewModel.raceMonth
            raceCountry.text = viewModel.raceCountry
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
}
