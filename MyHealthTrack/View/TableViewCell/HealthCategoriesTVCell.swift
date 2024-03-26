//
//  HealthCategoriesTVCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 11/01/24.
//

import UIKit

class HealthCategoriesTVCell: UITableViewCell {
 
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var titleIMG: UIImageView!
    
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
