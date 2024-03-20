//
//  SummaryTVCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 20/03/24.
//

import UIKit

class SummaryTVCell: UITableViewCell {
    
    @IBOutlet weak var cellview: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var cellData: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellview.layer.cornerRadius = 10
        cellview.clipsToBounds = true
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
