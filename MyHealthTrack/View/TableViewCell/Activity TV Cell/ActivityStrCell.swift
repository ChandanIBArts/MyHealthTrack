//
//  ActivityStrCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 17/01/24.
//

import UIKit

class ActivityStrCell: UITableViewCell {

    @IBOutlet weak var strLbl: UILabel!
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
