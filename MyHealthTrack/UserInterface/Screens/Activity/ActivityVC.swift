//
//  ActivityVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 12/01/24.
//

import UIKit

class ActivityVC: UIViewController {
    
    let healthKitManager = HealthKitmanager()
    
    
    @IBOutlet weak var lblHeding: UILabel!
    @IBOutlet weak var activityTableView: UITableView!
   
    
   // var activityStsticRecord = ActivityStaticRecord.activityStaticData
    var myRecord = [ActivityRecord]()
    var strRecord = strActivityRecord.strActivityData
    override func viewDidLoad() {
        super.viewDidLoad()
        myRecord.removeAll()
        healthKitManager.requestAuthorization{
            mod in
            DispatchQueue.main.async {
                self.myRecord = mod ?? []
                self.activityTableView.reloadData()
            }
            
        }
        customeTblViewBorder()
        activityTableView.dataSource = self
        activityTableView.delegate = self
        activityTableView.register(UINib(nibName: "ActivityTVCell", bundle: nil), forCellReuseIdentifier: "ActivityTVCell")
        activityTableView.register(UINib(nibName: "ActivityInCell", bundle: nil), forCellReuseIdentifier: "ActivityInCell")
        activityTableView.register(UINib(nibName: "ActivityStrCell", bundle: nil), forCellReuseIdentifier: "ActivityStrCell")
        activityTableView.reloadData()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func customeTblViewBorder(){
        activityTableView.layer.cornerRadius = 8
        activityTableView.clipsToBounds = true
    }

    @IBAction func btnReturn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

}

extension ActivityVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return myRecord.count
        } else if section == 1 {
            return 1
        } else {
            return strRecord.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = activityTableView.dequeueReusableCell(withIdentifier: "ActivityTVCell", for: indexPath) as! ActivityTVCell
            
            var index = indexPath.row
            
            cell.lblActivity.text = myRecord[index].title
            cell.lblTime.text = myRecord[index].time
            cell.lblMesermentINT.text = (myRecord[index].datavalu ?? "") + " " + (myRecord[index].dataUnit ?? "")
            
            cell.selectionStyle = .none
            
            return cell
        } else if indexPath.section == 1 {
            let cell = activityTableView.dequeueReusableCell(withIdentifier: "ActivityInCell", for: indexPath) as! ActivityInCell
            
            cell.inLbl.text = "No Data Available"
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = activityTableView.dequeueReusableCell(withIdentifier: "ActivityStrCell", for: indexPath) as! ActivityStrCell
            
            cell.strLbl.text = strRecord[indexPath.row].strData
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        } else if indexPath.section == 1 {
            return 50
        } else {
            return 65
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            var str = myRecord[indexPath.row].title
          
            if str == "Walking + Running Distance" {
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Details_Walking_RunningDistanceVC") as! Details_Walking_RunningDistanceVC
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
            if str == "Steps" {
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Details_StepsVC") as! Details_StepsVC
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
            if str == "Active Energy" {
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Details_ActiveEnrgyVC") as! Details_ActiveEnrgyVC
                
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }
            
            if str == "Resting Energy" {
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Details_RestingEnergyVC") as! Details_RestingEnergyVC
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
            
            if str == "Stairs Climbed" {
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Details_StairsClimbedVC") as! Details_StairsClimbedVC
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }
    }
    
}


