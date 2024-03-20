//
//  DetailsWalkingStepLengthVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 18/03/24.
//

import UIKit

class DetailsWalkingStepLengthVC: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var strLblArr = ["Step length is the distance between your front foot and back foot when you're walking. The ability to take longer steps is related to your long-term mobility. \n\nWalking requires strength and coordination. Changes in these can affect your ability to take longer steps. \n\nStep length naturally varies with how fast you walk, your height and the terrain you're on, but may decline with age, injury or other factors. \n\nYour iPhone can record step length automatically when you carry your phone near your waist — such as in a pocket - and walk steadily on flat ground. To ensure accuracy, check your height is up to date in Body Measurements."]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "WalkingStepLengthChartCell", bundle: nil), forCellReuseIdentifier: "WalkingStepLengthChartCell")
        tableview.register(UINib(nibName: "WalkingStepLengthStaticCell", bundle: nil), forCellReuseIdentifier: "WalkingStepLengthStaticCell")
    }
    

    @IBAction func btnTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension DetailsWalkingStepLengthVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return strLblArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WalkingStepLengthChartCell", for: indexPath) as! WalkingStepLengthChartCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WalkingStepLengthStaticCell", for: indexPath) as! WalkingStepLengthStaticCell
            cell.txtLbl.text = strLblArr[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 500
        } else {
            return 500
        }
    }
    
}
