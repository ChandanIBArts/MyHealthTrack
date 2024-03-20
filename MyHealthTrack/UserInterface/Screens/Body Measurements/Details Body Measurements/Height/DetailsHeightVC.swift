//
//  DetailsHeightVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 19/03/24.
//

import UIKit

class DetailsHeightVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var strArr = WeightImgModel.weightModel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HeightChartCell", bundle: nil), forCellReuseIdentifier: "HeightChartCell")
        tableView.register(UINib(nibName: "HeightStaticCell", bundle: nil), forCellReuseIdentifier: "HeightStaticCell")
     
    }
    

    @IBAction func btnTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
extension DetailsHeightVC: UITableViewDataSource, UITableViewDelegate {
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeightChartCell", for: indexPath) as! HeightChartCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeightStaticCell", for: indexPath) as! HeightStaticCell
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
