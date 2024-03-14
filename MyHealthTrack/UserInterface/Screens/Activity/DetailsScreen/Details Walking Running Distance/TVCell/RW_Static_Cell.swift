//
//  RW_Static_Cell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 27/02/24.
//

import UIKit

class RW_Static_Cell: UITableViewCell {
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
