//
//  VitalsVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 15/01/24.
//

import UIKit

class VitalsVC: UIViewController {
    
    let vitalshealthStore = VitalsHealthKitManager()
    var vitalsRecord = [VitalsRecord]()
    var strRecord = strVitalsRecord.strVitalsData

    @IBOutlet weak var vitalsTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        vitalshealthStore.requestAuthorization(){
            mod in
            DispatchQueue.main.async { [self] in
                self.vitalsRecord = mod ?? []
                self.vitalsTableView.reloadData()
            }
        }
        customeTblViewBorder()
        vitalsTableView.dataSource = self
        vitalsTableView.delegate = self
        vitalsTableView.register(UINib(nibName: "VitalsTVCell", bundle: nil), forCellReuseIdentifier: "VitalsTVCell")
        vitalsTableView.register(UINib(nibName: "StrVitalsTVCell", bundle: nil), forCellReuseIdentifier: "StrVitalsTVCell")
        vitalsTableView.register(UINib(nibName: "VitalsInTVCell", bundle: nil), forCellReuseIdentifier: "VitalsInTVCell")
        vitalsTableView.reloadData()
       
        /*VitalsInTVCell*/
    }
    
    func customeTblViewBorder(){
        vitalsTableView.layer.cornerRadius = 8
        vitalsTableView.clipsToBounds = true
        
       
    }

    @IBAction func btnTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension VitalsVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
       return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return vitalsRecord.count
        } else if section == 1 {
            return 1
        }
        else{
            return strRecord.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = vitalsTableView.dequeueReusableCell(withIdentifier: "VitalsTVCell", for: indexPath) as! VitalsTVCell
            
//            let today = Date.now
//            let formatter1 = DateFormatter()
//            formatter1.dateFormat = "hh:mm a"
//            print(formatter1.string(from: today))
            cell.lblTime.text = vitalsRecord[indexPath.row].time /*formatter1.string(from: today)*/
            cell.lblData.text = (vitalsRecord[indexPath.row].data ?? "") + " " + (vitalsRecord[indexPath.row].unit ?? "")
            cell.lblTitle.text = vitalsRecord[indexPath.row].title
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            let cell = vitalsTableView.dequeueReusableCell(withIdentifier: "VitalsInTVCell", for: indexPath) as! VitalsInTVCell
            cell.inLbl.text = "No Data Available"
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = vitalsTableView.dequeueReusableCell(withIdentifier: "StrVitalsTVCell", for: indexPath) as! StrVitalsTVCell
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
            if indexPath.row == 0 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsHartRateVC") as! DetailsHartRateVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}
