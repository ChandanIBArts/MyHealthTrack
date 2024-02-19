//
//  BodyMeasurementsVC.swift
//  MyHealthTrack
//
//  Created by Chandan Mondal on 13/01/24.
//

import UIKit

class BodyMeasurementsVC: UIViewController {
    
    @IBOutlet weak var bodyMeasurementTableView: UITableView!
    @IBOutlet weak var lblHeding: UILabel!
    
    let bodyHealthKitManager = BodyHealthKitManager()
    var myRecord = [BodyRecord]()
    var strRecord = strBodyRecord.strstrBodyRecord

    override func viewDidLoad() {
        super.viewDidLoad()
        myRecord.removeAll()
        bodyHealthKitManager.requestAuthorization{
            mod in
            DispatchQueue.main.async { [self] in
                self.myRecord = mod ?? []
                self.bodyMeasurementTableView.reloadData()
            }
        }
        customeTblViewBorder()
        bodyMeasurementTableView.dataSource = self
        bodyMeasurementTableView.delegate = self
        bodyMeasurementTableView.register(UINib(nibName: "BodyMeasurementsTVCell", bundle: nil), forCellReuseIdentifier: "BodyMeasurementsTVCell")
        bodyMeasurementTableView.register(UINib(nibName: "BodyInCell", bundle: nil), forCellReuseIdentifier: "BodyInCell")
        bodyMeasurementTableView.register(UINib(nibName: "BodyStrCell", bundle: nil), forCellReuseIdentifier: "BodyStrCell")
        bodyMeasurementTableView.reloadData()
    }
    
    func customeTblViewBorder(){
        bodyMeasurementTableView.layer.cornerRadius = 8
        bodyMeasurementTableView.clipsToBounds = true
    }

    @IBAction func btnTapBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

}

extension BodyMeasurementsVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return myRecord.count
        } else if section == 1 {
            return 1
        } else {
            return strRecord.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BodyMeasurementsTVCell", for: indexPath) as! BodyMeasurementsTVCell
//            let today = Date.now
//            let formatter1 = DateFormatter()
//            formatter1.dateFormat = "hh:mm a"
            cell.lblTime.text = myRecord[indexPath.row].time/*formatter1.string(from: today)*/
            cell.lblTitle.text = myRecord[indexPath.row].title
            cell.lblData.text = myRecord[indexPath.row].data
            cell.lblUnit.text = myRecord[indexPath.row].unit
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BodyInCell", for: indexPath) as! BodyInCell
            cell.inLbl.text = "No Data Available"
            cell.selectionStyle = .none
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BodyStrCell", for: indexPath) as! BodyStrCell
            cell.lblStr.text = strRecord[indexPath.row].strString
            cell.selectionStyle = .none
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
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

