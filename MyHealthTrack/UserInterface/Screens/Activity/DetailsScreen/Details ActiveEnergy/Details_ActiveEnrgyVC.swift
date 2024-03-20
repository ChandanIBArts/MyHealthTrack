//
//  Details_ActiveEnrgyVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 25/01/24.
//

import UIKit
import HealthKit

class Details_ActiveEnrgyVC: UIViewController {
 
    @IBOutlet weak var tableView: UITableView!
   
    var strTxtArr = ["You burned an average of 129 kilocalories a day over the last 7 days.","On average, you're burning fewer kilocalories this year compared to last vear.","This month your average kilocalorie burn is higher than it was last month."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ActiveEnrgyChartTVCell", bundle: nil), forCellReuseIdentifier: "ActiveEnrgyChartTVCell")
        tableView.register(UINib(nibName: "ActiveEnergy_Static_TVCell", bundle: nil), forCellReuseIdentifier: "ActiveEnergy_Static_TVCell")
    
    }
    
    @IBAction func btnTapBack(_ sender: UIButton) {
     
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnAddData(_ sender: UIButton) {
        
        print("Hello World")
    }
    
}


extension Details_ActiveEnrgyVC: UITableViewDataSource, UITableViewDelegate {
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveEnrgyChartTVCell", for: indexPath) as! ActiveEnrgyChartTVCell
            cell.selectionStyle = .none
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveEnergy_Static_TVCell", for: indexPath) as! ActiveEnergy_Static_TVCell
            cell.txtLbl.text = strTxtArr[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 550
        } else {
            return 130
        }
    }
   
}
