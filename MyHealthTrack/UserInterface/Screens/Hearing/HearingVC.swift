//
//  HearingVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 19/01/24.
//

import UIKit

class HearingVC: UIViewController {
    
    @IBOutlet weak var hearingTableview: UITableView!
    var myStrRecord = strHearingRecord.strHearingData

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customeTblViewBorder()
        hearingTableview.dataSource = self
        hearingTableview.delegate = self
        hearingTableview.register(UINib(nibName: "HearingTVCell", bundle: nil), forCellReuseIdentifier: "HearingTVCell")
        hearingTableview.register(UINib(nibName: "DefultHearingTVCell", bundle: nil), forCellReuseIdentifier: "DefultHearingTVCell")
        hearingTableview.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func customeTblViewBorder(){
        hearingTableview.layer.cornerRadius = 8
        hearingTableview.clipsToBounds = true
    }
  
    @IBAction func btnTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension HearingVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
            
        } else {
            return myStrRecord.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = hearingTableview.dequeueReusableCell(withIdentifier: "DefultHearingTVCell", for: indexPath) as! DefultHearingTVCell
            cell.title.text = "Headphone Audio Levels"
            cell.selectionStyle = .none
            return cell
            
        } else {
            
            let cell = hearingTableview.dequeueReusableCell(withIdentifier: "HearingTVCell", for: indexPath) as! HearingTVCell
            cell.strLbl.text = myStrRecord[indexPath.row].strData
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 90
        } else {
            return 65
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsHearingVC") as! DetailsHearingVC
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    
    
}
