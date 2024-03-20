//
//  DetailsDoubleSupportVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 19/02/24.
//

import UIKit
import HealthKit

class DetailsDoubleSupportVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var strTxtArr = [ "This is the percentage of time during a walk that both feet are on the ground. A lower value means you spend more of your walk with your weight on one foot instead of two, which can be a sign of better balance. During a typical walk, this measure will fall between 20 and 40%.\n \nWalking requires strength and coordination. Changes in these can affect your balance and two-foot contact time \n \nDouble support time naturally varies with how fast you walk and the terrain, but may increase with age. \n \nDouble support time is recorded automatically on iPhone when you carry your phone near your waist, such as in a trouser pocket, and walk steadily over flat ground."]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DoubleSupportChartCell", bundle: nil), forCellReuseIdentifier: "DoubleSupportChartCell")
        tableView.register(UINib(nibName: "DoubleSupport_Static_Cell", bundle: nil), forCellReuseIdentifier: "DoubleSupport_Static_Cell")
    }
    
   
    @IBAction func btnTapBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
   
    
    
    
}



extension DetailsDoubleSupportVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return strTxtArr.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoubleSupportChartCell", for: indexPath) as! DoubleSupportChartCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoubleSupport_Static_Cell", for: indexPath) as! DoubleSupport_Static_Cell
            cell.textLbl.text = strTxtArr[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 500
        } else {
            return 450
        }
    }
    
    
}
