//
//  DetailsWalkingAsymmetryVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 18/03/24.
//

import UIKit

class DetailsWalkingAsymmetryVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var strLblArr = ["In a healthy walking pattern, the timing of the steps you take with each foot is very similar. Walking asymmetry is the percentage of time your steps with one foot are faster or slower than the other foot. This means the lower the \n\npercentage of asymmetry, the healthier your walking pattern. \n\nUneven walking patterns, such as limping, can be a sign of disease, injury or other health issues. An even or symmetrical walk is often an important physical therapy goal when recovering from injury. \n\nYour iPhone can record walking asymmetry automatically when you carry your phone near your waist — such as in a pocket — and walk steadily on flat ground."]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "WalkingAsymmetryChartCell", bundle: nil), forCellReuseIdentifier: "WalkingAsymmetryChartCell")
        tableView.register(UINib(nibName: "WalkingAsymmetryStaticCell", bundle: nil), forCellReuseIdentifier: "WalkingAsymmetryStaticCell")
        // Do any additional setup after loading the view.
    }

    @IBAction func btnTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
extension DetailsWalkingAsymmetryVC: UITableViewDataSource, UITableViewDelegate {
    
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
           let cell = tableView.dequeueReusableCell(withIdentifier: "WalkingAsymmetryChartCell", for: indexPath) as! WalkingAsymmetryChartCell
           cell.selectionStyle = .none
           return cell
       } else {
           let cell = tableView.dequeueReusableCell(withIdentifier: "WalkingAsymmetryStaticCell", for: indexPath) as! WalkingAsymmetryStaticCell
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
