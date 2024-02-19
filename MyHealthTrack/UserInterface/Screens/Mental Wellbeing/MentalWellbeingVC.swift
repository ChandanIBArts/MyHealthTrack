//
//  MentalWellbeingVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 11/01/24.
//

import UIKit

class MentalWellbeingVC: UIViewController {
    
    @IBOutlet weak var lblDataAvailableOrNot: UILabel!
    @IBOutlet weak var mentalTableView: UITableView!
    
    var mentalRecords = MentalRecord.mentalData
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customeTblViewBorder()
        mentalTableView.dataSource = self
        mentalTableView.delegate = self
        mentalTableView.register(UINib(nibName: "MentalWellbeingTVCell", bundle: nil), forCellReuseIdentifier: "MentalWellbeingTVCell")
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mentalRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MentalWellbeingTVCell", for: indexPath) as! MentalWellbeingTVCell
        
        cell.titleLbl.text = mentalRecords[indexPath.row].title
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
    
}
