//
//  Details_StairsClimbedVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 25/01/24.
//

import UIKit
import HealthKit

class Details_StairsClimbedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var strTxtArr = ["A flight of stairs is counted as approximately 3 metres (10 feet) of elevation gain (approximately 16 steps)."]

    override func viewDidLoad() {
        super.viewDidLoad()
   
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "StairsClimbedChartTVCell", bundle: nil), forCellReuseIdentifier: "StairsClimbedChartTVCell")
        tableView.register(UINib(nibName: "StairsClimbed_Static_TVCell", bundle: nil), forCellReuseIdentifier: "StairsClimbed_Static_TVCell")
        tableView.reloadData()
        
    }
    
    @IBAction func btnTapBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
        
    
    @IBAction func btnAddData(_ sender: UIButton) {
        
        print("Hello World")
        
    }
    
     
}

extension Details_StairsClimbedVC: UITableViewDataSource, UITableViewDelegate {
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "StairsClimbedChartTVCell", for: indexPath) as! StairsClimbedChartTVCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StairsClimbed_Static_TVCell", for: indexPath) as! StairsClimbed_Static_TVCell
            cell.txtLbl.text = strTxtArr[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 550
        } else {
            return 150
        }
    }
    
    
    
    
}
