//
//  MobilityTVCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 18/01/24.
//

import UIKit

class MobilityTVCell: UITableViewCell {
    
    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dataLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackground.layer.cornerRadius = 8
        cellBackground.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
