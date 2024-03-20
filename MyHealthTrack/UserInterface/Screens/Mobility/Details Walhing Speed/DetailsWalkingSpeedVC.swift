//
//  DetailsWalkingSpeedVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 18/03/24.
//

import UIKit
import HealthKit

class DetailsWalkingSpeedVC: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    var strLblArr = ["Walking speed represents how quickly you walk on flat ground. Walking speeds may be associated with how well you move overall and your physical abilities. \n\nWalking requires strength, coordination and aerobic fitness. Changes in any of these can affect your walking speed. \n\nWalking speed tends to slow down as you get older, but sudden decreases may indicate a change in your health.\n\nYour iPhone can record walking speed automatically when you carry your phone near your waist — such as in a pocket - and walk steadily on flat ground. To ensure accuracy, check your height is up to date in Body Measurements.\n\nWalking Speed is not recorded if your Wheelchair status is set to on."]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "WalkingSpeedChartCell", bundle: nil), forCellReuseIdentifier: "WalkingSpeedChartCell")
        tableView.register(UINib(nibName: "WalkingSpeedStaticCell", bundle: nil), forCellReuseIdentifier: "WalkingSpeedStaticCell")
    }
    

    @IBAction func btnTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
   

}

 extension DetailsWalkingSpeedVC: UITableViewDataSource, UITableViewDelegate {
     
     func numberOfSections(in tableView: UITableView) -> Int {
         return 2
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return strLblArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WalkingSpeedChartCell", for: indexPath) as! WalkingSpeedChartCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WalkingSpeedStaticCell", for: indexPath) as! WalkingSpeedStaticCell
            cell.txtLbl.text = strLblArr[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    
 }
