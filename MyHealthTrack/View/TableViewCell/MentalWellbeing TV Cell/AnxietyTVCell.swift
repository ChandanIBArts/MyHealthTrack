//
//  AnxietyTVCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 20/02/24.
//

import UIKit

class AnxietyTVCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cellBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackground.layer.cornerRadius = 8
        cellBackground.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
