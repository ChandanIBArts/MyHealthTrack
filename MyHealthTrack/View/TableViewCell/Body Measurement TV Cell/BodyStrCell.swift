//
//  BodyStrCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 16/01/24.
//

import UIKit

class BodyStrCell: UITableViewCell {

    @IBOutlet weak var lblStr: UILabel!
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
