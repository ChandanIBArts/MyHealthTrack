//
//  StepsVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 25/01/24.
//

import UIKit
import HealthKit

class Details_StepsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var strTxtArr = ["You're walking less than you usually do by this point.","You're averaging fewer steps a day this year than last year.","On average, your steps this month are fewer than last month."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "StepsChrtTVCell", bundle: nil), forCellReuseIdentifier: "StepsChrtTVCell")
        tableView.register(UINib(nibName: "Steps_Static_TVCell", bundle: nil), forCellReuseIdentifier: "Steps_Static_TVCell")
   
    }
    
    @IBAction func btnTapBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnAddData(_ sender: UIButton) {
        
        print("Hello World")
        
    }
    
   
}

extension Details_StepsVC: UITableViewDelegate, UITableViewDataSource {
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "StepsChrtTVCell", for: indexPath) as! StepsChrtTVCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Steps_Static_TVCell", for: indexPath) as! Steps_Static_TVCell
            cell.textLbl.text = strTxtArr[indexPath.row]
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
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
