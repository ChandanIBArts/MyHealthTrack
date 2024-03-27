//
//  SleepVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 18/01/24.
//

import UIKit
import DGCharts

class SleepVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var img = ImgStore.SleepImg
    var strTxtArr = ["Sleep provides insight into your sleep habits.Sleep trackers and monitors can help you determine the amount of time you are in bed and asleep. These devices estimate your time in bed and your time asleep by analysing changes in physical activity, including movement during the night. You can also keep track of your sleep by entering your own estimation of your time in bed and time asleep manually. \n\nThe In Bed period reflects the time period you are lying in bed with the intention to sleep. For most people, it starts when you turn the lights off and it ends when you get out of bed. The Asleep period reflects the period(s) you are asleep."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SleepChartCell", bundle: nil), forCellReuseIdentifier: "SleepChartCell")
        tableView.register(UINib(nibName: "AboutSleepCell", bundle: nil), forCellReuseIdentifier: "AboutSleepCell")
        tableView.register(UINib(nibName: "ImgSleepCell", bundle: nil), forCellReuseIdentifier: "ImgSleepCell")
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func btnTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTapAddDatra(_ sender: UIButton) {
        let alert = UIAlertController(title: "My Health Track", message: "User cannot add data", preferredStyle: .alert)
        let Ok = UIAlertAction(title: "Ok", style: .destructive)
        alert.addAction(Ok)
        present(alert, animated: true)
    }
    

}
extension SleepVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return strTxtArr.count
        } else {
            return img.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SleepChartCell", for: indexPath) as! SleepChartCell
            cell.btnTapQuestion.tag = indexPath.row
            cell.btnTapQuestion.addTarget(self, action: #selector(playAlert), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutSleepCell", for: indexPath) as! AboutSleepCell
            cell.txtLbl.text = strTxtArr[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImgSleepCell", for: indexPath) as! ImgSleepCell
            cell.imgView.image = img[indexPath.row].img
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 450
        } else if indexPath.section == 1 {
            return 400
        } else {
            return 200
        }
    }
    
    
    @objc func playAlert(_ sender: UIButton){
        let alert = UIAlertController(title: "My Health Track", message: "While we sleep, our brains and bodies restore themselves. Each sleep stage plays a different role, but they're all essential to waking up refreshed.", preferredStyle: .alert)
        let Ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(Ok)
        present(alert, animated: true)
    }
    
}



