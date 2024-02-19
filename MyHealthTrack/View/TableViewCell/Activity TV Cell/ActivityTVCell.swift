//
//  ActivityTVCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 12/01/24.
//

import UIKit

class ActivityTVCell: UITableViewCell {
    
    @IBOutlet weak var lblActivity: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblMesermentINT: UILabel!
    
    @IBOutlet weak var lblTypeMeserment: UILabel!
    
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
