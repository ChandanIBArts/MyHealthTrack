//
//  DetailsWeightVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 15/03/24.
//

import UIKit

class DetailsWeightVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var strArr = WeightImgModel.weightModel

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "WeightChartCell", bundle: nil), forCellReuseIdentifier: "WeightChartCell")
        tableView.register(UINib(nibName: "WeightStaticCell", bundle: nil), forCellReuseIdentifier: "WeightStaticCell")
    }
    
    @IBAction func btnTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
extension DetailsWeightVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return strArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeightChartCell", for: indexPath) as! WeightChartCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeightStaticCell", for: indexPath) as! WeightStaticCell
            cell.imgView.image = strArr[indexPath.row].img
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 500
        } else {
            return 100
        }
    }
    
    
}
