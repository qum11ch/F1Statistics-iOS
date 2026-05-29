//
//  DriverTableCellViewController.swift
//  F1Statistics
//
//  Created by Никита Шарапатов on 29.05.2026.
//

import UIKit

class DriverTableCellViewController: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with viewModel: DriverTableCellViewController) {
        
        driverPosition: standing.position,
        driverFullName: driver.fullName,
        driverPoints: "\(standing.points) PTS",
        driverTeam: constructor
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
}

