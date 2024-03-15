//
//  DetailsHearingVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 14/03/24.
//

import UIKit

class DetailsHearingVC: UIViewController {
    
    
    @IBOutlet weak var hearingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        hearingTableView.dataSource = self
        hearingTableView.delegate = self
        hearingTableView.register(UINib(nibName: "HearingBarchatTVCell", bundle: nil), forCellReuseIdentifier: "HearingBarchatTVCell")
        hearingTableView.register(UINib(nibName: "HearingStaticTVCell", bundle: nil), forCellReuseIdentifier: "HearingStaticTVCell")
        
        // HearingBarchatTVCell
    }
    
    @IBAction func btnTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    


}

extension DetailsHearingVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 1
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HearingBarchatTVCell", for: indexPath) as! HearingBarchatTVCell
            cell.selectionStyle = .none
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HearingStaticTVCell", for: indexPath) as! HearingStaticTVCell
            cell.selectionStyle = .none
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 350
        } else {
            return 500
        }
    }
    
}
