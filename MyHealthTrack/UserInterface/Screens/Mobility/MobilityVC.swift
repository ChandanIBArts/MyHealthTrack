//
//  MobilityVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 18/01/24.
//

import UIKit

class MobilityVC: UIViewController {
    
    @IBOutlet weak var mobilityTableView: UITableView!
    let mobilityhealthStore = MobilityHealthKitManager()
  
    var mobilityRecord = [MobilityRecord]()
    var strRecord = strMobilityRecord.strMobilityData


    override func viewDidLoad() {
        super.viewDidLoad()
        
        mobilityhealthStore.requestAuthorization(){
            mod in
            DispatchQueue.main.async { [self] in
                self.mobilityRecord = mod ?? []
                self.mobilityTableView.reloadData()
            }
        }
        customeTblViewBorder()
        mobilityTableView.dataSource = self
        mobilityTableView.delegate = self
        mobilityTableView.register(UINib(nibName: "MobilityTVCell", bundle: nil), forCellReuseIdentifier: "MobilityTVCell")
        mobilityTableView.register(UINib(nibName: "MobilityInTVCell", bundle: nil), forCellReuseIdentifier: "MobilityInTVCell")
        mobilityTableView.register(UINib(nibName: "StrMobilityTVCell", bundle: nil), forCellReuseIdentifier: "StrMobilityTVCell")
        mobilityTableView.reloadData()
    }
    
    
    @IBAction func btnBackTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func customeTblViewBorder(){
        mobilityTableView.layer.cornerRadius = 8
        mobilityTableView.clipsToBounds = true
    }
    
}

extension MobilityVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return mobilityRecord.count
        } else if section == 1 {
            return 1
        }
        else{
            return strRecord.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = mobilityTableView.dequeueReusableCell(withIdentifier: "MobilityTVCell", for: indexPath) as! MobilityTVCell
            cell.titleLbl.text = mobilityRecord[indexPath.row].title
            cell.dataLBL.text = (mobilityRecord[indexPath.row].data ?? "") + " " + (mobilityRecord[indexPath.row].unit ?? "")
            cell.timeLbl.text = mobilityRecord[indexPath.row].time
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            
            let cell = mobilityTableView.dequeueReusableCell(withIdentifier: "MobilityInTVCell", for: indexPath) as! MobilityInTVCell
            
            cell.inLbl.text = "No Data Available"
            cell.selectionStyle = .none
            return cell
            
        } else {
            
            let cell = mobilityTableView.dequeueReusableCell(withIdentifier: "StrMobilityTVCell", for: indexPath) as! StrMobilityTVCell

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
    
}
