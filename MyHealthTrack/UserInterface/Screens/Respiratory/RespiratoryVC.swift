//
//  RespiratoryVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 18/01/24.
//

import UIKit

class RespiratoryVC: UIViewController {
    
    @IBOutlet weak var resporatoryTableView: UITableView!
    var myRecord = strRespiratoryRecord.strRespiratoryData

    override func viewDidLoad() {
        super.viewDidLoad()
        customeTblViewBorder()
        resporatoryTableView.dataSource = self
        resporatoryTableView.delegate = self
        resporatoryTableView.register(UINib(nibName: "RespiratoryTVCell", bundle: nil), forCellReuseIdentifier: "RespiratoryTVCell")
        resporatoryTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func customeTblViewBorder(){
        resporatoryTableView.layer.cornerRadius = 8
        resporatoryTableView.clipsToBounds = true
    }

}

extension RespiratoryVC: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRecord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resporatoryTableView.dequeueReusableCell(withIdentifier: "RespiratoryTVCell", for: indexPath) as! RespiratoryTVCell
        
        cell.strLbl.text = myRecord[indexPath.row].strData
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}
