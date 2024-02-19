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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myStrRecord.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hearingTableview.dequeueReusableCell(withIdentifier: "HearingTVCell", for: indexPath) as! HearingTVCell
        cell.strLbl.text = myStrRecord[indexPath.row].strData
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
}
