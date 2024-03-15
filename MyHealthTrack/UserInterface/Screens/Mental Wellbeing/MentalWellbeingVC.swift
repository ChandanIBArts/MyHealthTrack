//
//  MentalWellbeingVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 11/01/24.
//

import UIKit

class MentalWellbeingVC: UIViewController {

    @IBOutlet weak var mentalTableView: UITableView!
    
    var mentalRecords = MentalRecord.mentalData
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customeTblViewBorder()
        mentalTableView.dataSource = self
        mentalTableView.delegate = self
        mentalTableView.register(UINib(nibName: "MentalWellbeingTVCell", bundle: nil), forCellReuseIdentifier: "MentalWellbeingTVCell")
        mentalTableView.register(UINib(nibName: "MentalNoDataTVCell", bundle: nil), forCellReuseIdentifier: "MentalNoDataTVCell")
        mentalTableView.register(UINib(nibName: "AnxietyTVCell", bundle: nil), forCellReuseIdentifier: "AnxietyTVCell")
        mentalTableView.reloadData()
        // Do any additional setup after loading the view.
    }
 
    func customeTblViewBorder(){
        mentalTableView.layer.cornerRadius = 8
        mentalTableView.clipsToBounds = true
    }
    
    @IBAction func btnTapBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
extension MentalWellbeingVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return mentalRecords.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnxietyTVCell", for: indexPath) as! AnxietyTVCell
            cell.title.text = "Anxiety Risk"
            cell.selectionStyle = .none
            return cell
            
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MentalNoDataTVCell", for: indexPath) as! MentalNoDataTVCell
            cell.nodataLvl.text = "No data Available"
            cell.selectionStyle = .none
            return cell
            
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MentalWellbeingTVCell", for: indexPath) as! MentalWellbeingTVCell
            
            cell.titleLbl.text = mentalRecords[indexPath.row].title
            cell.selectionStyle = .none
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else if indexPath.section == 1 {
            return 65
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AnexietyRiskVC") as! AnexietyRiskVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
}
