//
//  BodyMeasurementsTVCell.swift
//  MyHealthTrack
//
//  Created by Chandan Mondal on 13/01/24.
//

import UIKit

class BodyMeasurementsTVCell: UITableViewCell {
    
    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
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
