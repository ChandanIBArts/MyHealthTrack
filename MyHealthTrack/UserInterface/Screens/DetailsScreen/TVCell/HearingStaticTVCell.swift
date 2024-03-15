//
//  HearingStaticTVCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 14/03/24.
//

import UIKit

class HearingStaticTVCell: UITableViewCell {
    
    @IBOutlet weak var txtView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI(view: txtView)
        setUpUI(view: imgView)
        // Initialization code
    }
    
    func setUpUI(view: UIView){
        
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
