//
//  MentalWellbeingTVCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 11/01/24.
//

import UIKit

class MentalWellbeingTVCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var cellBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellBackground.layer.cornerRadius = 8
        cellBackground.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
