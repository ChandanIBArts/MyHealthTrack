//
//  Walking+RunningDistanceVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 23/01/24.
//

import UIKit
import HealthKit

class Details_Walking_RunningDistanceVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    
    var strTxtArr = ["You averaged 3.1 kilometres of distance walked and run over the last 7 days.","On average, you've walked and run less this year than you did last year.","On average, you haven't walked and run as far this month as last month."]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "RunningWalkingChartTVCell", bundle: nil), forCellReuseIdentifier: "RunningWalkingChartTVCell")
        tableView.register(UINib(nibName: "RunningWalking_Static_TVCell", bundle: nil), forCellReuseIdentifier: "RunningWalking_Static_TVCell")
     
    }
    
    
    
    
    @IBAction func tapBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

    
    
    @IBAction func btnAddData(_ sender: UIButton) {
        
        print("Hello World")
    }
    

}

extension Details_Walking_RunningDistanceVC: UITableViewDataSource,UITableViewDelegate {
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "RunningWalkingChartTVCell", for: indexPath) as! RunningWalkingChartTVCell
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RunningWalking_Static_TVCell", for: indexPath) as! RunningWalking_Static_TVCell
        cell.txtLbl.text = strTxtArr[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 550
        } else {
            return 130
        }
        
    }
    
    
}



