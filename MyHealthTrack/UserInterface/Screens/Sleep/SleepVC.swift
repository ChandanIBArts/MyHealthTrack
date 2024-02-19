//
//  SleepVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 18/01/24.
//

import UIKit

class SleepVC: UIViewController {
    
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var lblUpdateDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentBar(_ sender: UISegmentedControl) {
        switch segmentBar.selectedSegmentIndex {
        case 0:
            lblUpdateDate.text = "18 Jan 2024"
        case 1:
            lblUpdateDate.text = "14 - 20 Jan 2024"
        case 2:
            lblUpdateDate.text = "Jan 2024"
        case 3:
            lblUpdateDate.text = "31 Dec 2023 - 29 Jun 2024"
        default:
            break
        }
        
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
    
    @IBAction func btnTapQuestion(_ sender: UIButton) {
        let alert = UIAlertController(title: "My Health Track", message: "No record found", preferredStyle: .alert)
        let Ok = UIAlertAction(title: "Ok", style: .destructive)
        alert.addAction(Ok)
        present(alert, animated: true)
    }
    
    
}


