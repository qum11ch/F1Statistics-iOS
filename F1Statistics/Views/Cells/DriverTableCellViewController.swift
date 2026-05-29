//
//  DriverTableCellViewController.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 29.05.2026.
//

import UIKit

class DriverTableCellViewController: UITableViewCell {

    @IBOutlet weak var driverPoints: UILabel!
    @IBOutlet weak var driverTeam: UILabel!
    @IBOutlet weak var driverFullName: UILabel!
    @IBOutlet weak var driverPosition: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with viewModel: DriverCellViewModel) {
        driverTeam.text = viewModel.driverTeam
        driverPoints.text = viewModel.driverPoints
        driverPosition.text = viewModel.driverPosition
        driverFullName.text = viewModel.driverFullName
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
}

