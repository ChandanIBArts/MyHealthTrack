//
//  AnexietyRiskVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 20/02/24.
//

import UIKit
import HealthKit

class AnexietyRiskVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var staticData = StaticModel.AnxietyModel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AnexietyChartCell", bundle: nil), forCellReuseIdentifier: "AnexietyChartCell")
        tableView.reloadData()
        
    }
    
    
    
    @IBAction func btnTapBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
     
}

extension AnexietyRiskVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 1
        } else {
            return staticData.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnexietyChartCell", for: indexPath) as! AnexietyChartCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Static_Anexiety_TextCell", for: indexPath) as! Static_Anexiety_TextCell
            cell.lblTitle.text = "About Anxiety Risk"
            cell.lblDescrip.text = "Anxiety risk refers to an individual's risk of anxiety-related mental health conditions. This reflects the risk at the time of the most recent mental health assessment score based on the Generalised Anxiety Disorder. \n \nQuestionnaire-7 (GAD-7). The GAD-7 is a tool doctors use to help screen for and measure someone's anxiety symptoms over a two-week period. A mental health questionnaire can be an important part of learning about what's impacting your mental health. Depending on your family history, biology or current life events, your anxiety risk may go up or down. \n \nAnxiety is a common and treatable condition. Your anxiety risk is not a diagnosis of any health condition. If you have any questions about your mental health, you should bring them up with a doctor. You can learn more about your current risk of anxiety by taking a mental health questionnaire in Health."
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Static_Anexiety_ImgCell", for: indexPath) as! Static_Anexiety_ImgCell
            cell.imgView.image = staticData[indexPath.row].img
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 500
            
        } else if indexPath.section == 1 {
             
            return 480
            
        } else {
            
            return 250
            
        }
    }
    
    
}
