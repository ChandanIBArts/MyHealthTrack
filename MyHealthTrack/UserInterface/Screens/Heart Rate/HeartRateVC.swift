//
//  HearingVC.swift
//  MyHealthTrack
//
//  Created by Chandan Mondal on 13/01/24.
//

import UIKit

class HeartRateVC: UIViewController {
    
    @IBOutlet weak var lblHeding: UILabel!
    @IBOutlet weak var heartRateTableview: UITableView!
    
    let bodyHealthKitManager = HeartHealthKitManager()
    var heartbitRecord = [HearRateRecord]()
    var strRecord = StrHearRateRecord.strheartData

    override func viewDidLoad() {
        super.viewDidLoad()
        customeTblViewBorder()
        bodyHealthKitManager.requestAuthorization{
            mod in
            DispatchQueue.main.async { [self] in
                self.heartbitRecord = mod ?? []
                self.heartRateTableview.reloadData()
                print(heartbitRecord)
            }
        }
       
        
        heartRateTableview.dataSource = self
        heartRateTableview.delegate = self
        heartRateTableview.register(UINib(nibName: "HeartRateTVCell", bundle: nil), forCellReuseIdentifier: "HeartRateTVCell")
        heartRateTableview.register(UINib(nibName: "StrHeartRateTVCell", bundle: nil), forCellReuseIdentifier: "StrHeartRateTVCell")
        heartRateTableview.register(UINib(nibName: "InTVCell", bundle: nil), forCellReuseIdentifier: "InTVCell")
    }
    
    func customeTblViewBorder(){
        heartRateTableview.layer.cornerRadius = 8
        heartRateTableview.clipsToBounds = true
    }
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension HeartRateVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
       return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return heartbitRecord.count
        } else if section == 1 {
            return 1
        } else {
            return strRecord.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeartRateTVCell", for: indexPath) as! HeartRateTVCell
        
            cell.lblTime.text = heartbitRecord[indexPath.row].time
            cell.lblData.text = (heartbitRecord[indexPath.row].data ?? "") + " " + (heartbitRecord[indexPath.row].unit ?? "")
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InTVCell", for: indexPath) as! InTVCell
            cell.inLbl.text = "No Data Available"
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StrHeartRateTVCell", for: indexPath) as! StrHeartRateTVCell
            cell.strLbl.text = strRecord[indexPath.row].strData
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
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
            if indexPath.row == 0 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsHartRateVC") as! DetailsHartRateVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}

