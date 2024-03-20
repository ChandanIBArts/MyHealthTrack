//
//  HartRateVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 19/02/24.
//

import UIKit
import Charts
import DGCharts
import HealthKit

class DetailsHartRateVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var strTxtArr = ["Your heart beats approximately 100,000 times per day, accelerating and slowing through periods of rest and exertion. Your heart rate refers to how many times your heart beats per minute and can be an indicator of your cardiovascular health. \n \nHealth visualises a history of the heart rate data collected by Apple Watch or a heart rate monitor so you can see your patterns and variability over time and with different activities."]
    var staticData = StaticModel.HeartModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HeartRateChartTVCell", bundle: nil), forCellReuseIdentifier: "HeartRateChartTVCell")
        tableView.reloadData()
        
        
    }
    

    @IBAction func btnTapBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension DetailsHartRateVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return strTxtArr.count
        } else {
            return staticData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeartRateChartTVCell", for: indexPath) as! HeartRateChartTVCell
            cell.selectionStyle = .none
            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Static_Heart_TextCell", for: indexPath) as! Static_Heart_TextCell
            cell.lblTitle.text = "About Heart Rate"
            cell.lblDescrib.text = strTxtArr[indexPath.row]
            cell.selectionStyle = .none
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Static_Heart_imgCell", for: indexPath) as! Static_Heart_imgCell
            cell.imgView.image = staticData[indexPath.row].img
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            
            return 500
            
        } else if indexPath.section == 1 {
            
          return 250
            
        } else {
            
          return 250
            
        }
    }
    
}

