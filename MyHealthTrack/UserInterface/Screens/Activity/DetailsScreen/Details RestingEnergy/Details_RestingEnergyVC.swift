//
//  RestingEnergyVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 25/01/24.
//

import UIKit
import HealthKit

class Details_RestingEnergyVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var strTxtArr = ["This is an estimate of the energy your body uses each day while minimally active. Additional physical activity requires more energy over and above Resting Energy (see Active Energy)."]

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "RestingEnergyChartTVCell", bundle: nil), forCellReuseIdentifier: "RestingEnergyChartTVCell")
        tableView.register(UINib(nibName: "RestingEnergy_Static_TVCell", bundle: nil), forCellReuseIdentifier: "RestingEnergy_Static_TVCell")

    }
    
    @IBAction func btnTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
   
    
    @IBAction func btnAddData(_ sender: UIButton) {
        print("Hello World")
    }
    
   
}

extension Details_RestingEnergyVC: UITableViewDataSource, UITableViewDelegate {
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "RestingEnergyChartTVCell", for: indexPath) as! RestingEnergyChartTVCell
            cell.selectionStyle = .none
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RestingEnergy_Static_TVCell", for: indexPath) as! RestingEnergy_Static_TVCell
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 550
        } else {
            return 180
        }
    }
    
    
}
