//
//  WalkingStepLengthStaticCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 18/03/24.
//

import UIKit

class WalkingStepLengthStaticCell: UITableViewCell {
    
    @IBOutlet weak var txtLbl: UILabel!
    @IBOutlet weak var cellView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 10
        cellView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
