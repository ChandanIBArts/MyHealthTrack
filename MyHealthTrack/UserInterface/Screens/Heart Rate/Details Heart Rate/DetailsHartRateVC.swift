//
//  HartRateVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 19/02/24.
//

import UIKit
import Charts
import DGCharts
import HealthKit

class DetailsHartRateVC: UIViewController {
    
    
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
//    var dailyTotalCount = 0
//    var weeklyTotalCount = 0
//    var monthlyTotalCount = 0
//    var halfYearlyTotalCount = 0
//    var yearlyTotalCount = 0
    
    let healthKitManager = DetailsHeartRateHealthKitManager()
    var lineChartView = LineChartView()
    var staticData = StaticModel.HeartModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUi()
        fetchData()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        
    }
    

    @IBAction func btnTapBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func segmentBar(_ sender: UISegmentedControl) {
        switch segmentBar.selectedSegmentIndex {
        case 0:
            fetchData()
        case 1:
            fetchData1()
        case 2:
            fetchData2()
        case 3:
            fetchData3()
        case 4:
            fetchData4()
        case 5:
            fetchData5()
            
        default:
            break
        }
    }
   
    func fetchData(){
        // Dummy data
        let dataEntries: [ChartDataEntry] = [
            ChartDataEntry(x: 0.0, y: 20.0),
            ChartDataEntry(x: 1.0, y: 25.0),
            ChartDataEntry(x: 2.0, y: 18.0),
            ChartDataEntry(x: 3.0, y: 30.0),
            ChartDataEntry(x: 4.0, y: 22.0)
        ]

        let dataSet = LineChartDataSet(entries: dataEntries, label: "Hart Rate")
        dataSet.colors = [UIColor.systemPink]

        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelTextColor = .black
        lineChartView.leftAxis.labelTextColor = .black
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = true
        
    }
    
    func fetchData1(){
        // Dummy data
        let dataEntries: [ChartDataEntry] = [
            ChartDataEntry(x: 0.0, y: 5.0),
            ChartDataEntry(x: 1.0, y: 25.0),
            ChartDataEntry(x: 2.0, y: 10.0),
            ChartDataEntry(x: 3.0, y: 30.0),
            ChartDataEntry(x: 4.0, y: 22.0),
            ChartDataEntry(x: 5.0, y: 25.0),
            ChartDataEntry(x: 6.0, y: 10.0),
            ChartDataEntry(x: 7.0, y: 15.0),
            ChartDataEntry(x: 8.0, y: 25.0),
            ChartDataEntry(x: 9.0, y: 5.0),
            ChartDataEntry(x: 10.0, y: 30.0),
            ChartDataEntry(x: 11.0, y: 22.0),
            ChartDataEntry(x: 12.0, y: 25.0),
            ChartDataEntry(x: 13.0, y: 12.0),
            ChartDataEntry(x: 14.0, y: 20.0),
            ChartDataEntry(x: 15.0, y: 40.0),
            ChartDataEntry(x: 16.0, y: 18.0),
            ChartDataEntry(x: 17.0, y: 25.0),
            ChartDataEntry(x: 18.0, y: 20.0),
            ChartDataEntry(x: 19.0, y: 25.0),
            ChartDataEntry(x: 20.0, y: 18.0),
            ChartDataEntry(x: 21.0, y: 30.0),
            ChartDataEntry(x: 22.0, y: 22.0),
            ChartDataEntry(x: 23.0, y: 35.0)
        ]

        let dataSet = LineChartDataSet(entries: dataEntries, label: "Hart Rate")
        dataSet.colors = [UIColor.systemPink]

        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelTextColor = .black
        lineChartView.leftAxis.labelTextColor = .black
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = true
        
    }
    
    func fetchData2(){
        // Dummy data
        let dataEntries: [ChartDataEntry] = [
            ChartDataEntry(x: 0.0, y: 20.0),
            ChartDataEntry(x: 1.0, y: 25.0),
            ChartDataEntry(x: 2.0, y: 18.0),
            ChartDataEntry(x: 3.0, y: 30.0),
            ChartDataEntry(x: 4.0, y: 22.0),
            ChartDataEntry(x: 5.0, y: 25.0),
            ChartDataEntry(x: 6.0, y: 18.0)
        ]

        let dataSet = LineChartDataSet(entries: dataEntries, label: "Hart Rate")
        dataSet.colors = [UIColor.systemPink]

        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelTextColor = .black
        lineChartView.leftAxis.labelTextColor = .black
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = true
        
    }
    
    func fetchData3(){
        // Dummy data
        let dataEntries: [ChartDataEntry] = [
            ChartDataEntry(x: 0.0, y: 5.0),
            ChartDataEntry(x: 1.0, y: 10.0),
            ChartDataEntry(x: 2.0, y: 15.0),
            ChartDataEntry(x: 3.0, y: 20.0),
            ChartDataEntry(x: 4.0, y: 5.0),
            ChartDataEntry(x: 5.0, y: 30.0),
            ChartDataEntry(x: 6.0, y: 15.0),
            ChartDataEntry(x: 7.0, y: 40.0),
            ChartDataEntry(x: 8.0, y: 45.0),
            ChartDataEntry(x: 9.0, y: 50.0),
            ChartDataEntry(x: 10.0, y: 40.0),
            ChartDataEntry(x: 11.0, y: 30.0),
            ChartDataEntry(x: 12.0, y: 5.0),
            ChartDataEntry(x: 13.0, y: 15.0),
            ChartDataEntry(x: 14.0, y: 20.0),
            ChartDataEntry(x: 15.0, y: 25.0),
            ChartDataEntry(x: 16.0, y: 30.0),
            ChartDataEntry(x: 17.0, y: 45.0),
            ChartDataEntry(x: 18.0, y: 15.0),
            ChartDataEntry(x: 19.0, y: 20.0),
            ChartDataEntry(x: 20.0, y: 25.0),
            ChartDataEntry(x: 21.0, y: 50.0),
            ChartDataEntry(x: 22.0, y: 5.0),
            ChartDataEntry(x: 23.0, y: 25.0),
            ChartDataEntry(x: 24.0, y: 10.0),
            ChartDataEntry(x: 25.0, y: 30.0),
            ChartDataEntry(x: 26.0, y: 35.0),
            ChartDataEntry(x: 27.0, y: 45.0),
            ChartDataEntry(x: 28.0, y: 15.0),
            ChartDataEntry(x: 29.0, y: 30.0)
        ]

        let dataSet = LineChartDataSet(entries: dataEntries, label: "Hart Rate")
        dataSet.colors = [UIColor.systemPink]

        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelTextColor = .black
        lineChartView.leftAxis.labelTextColor = .black
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = true
        
    }
    
    func fetchData4(){
        // Dummy data
        let dataEntries: [ChartDataEntry] = [
            ChartDataEntry(x: 0.0, y: 20.0),
            ChartDataEntry(x: 1.0, y: 25.0),
            ChartDataEntry(x: 2.0, y: 18.0),
            ChartDataEntry(x: 3.0, y: 30.0),
            ChartDataEntry(x: 4.0, y: 18.0),
            ChartDataEntry(x: 5.0, y: 40.0)
        ]

        let dataSet = LineChartDataSet(entries: dataEntries, label: "Hart Rate")
        dataSet.colors = [UIColor.systemPink]

        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelTextColor = .black
        lineChartView.leftAxis.labelTextColor = .black
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = true
        
    }
    
    func fetchData5(){
        // Dummy data
        let dataEntries: [ChartDataEntry] = [
            ChartDataEntry(x: 0.0, y: 10.0),
            ChartDataEntry(x: 1.0, y: 5.0),
            ChartDataEntry(x: 2.0, y: 18.0),
            ChartDataEntry(x: 3.0, y: 30.0),
            ChartDataEntry(x: 4.0, y: 20.0),
            ChartDataEntry(x: 5.0, y: 18.0),
            ChartDataEntry(x: 6.0, y: 10.0),
            ChartDataEntry(x: 7.0, y: 25.0),
            ChartDataEntry(x: 8.0, y: 18.0),
            ChartDataEntry(x: 9.0, y: 30.0),
            ChartDataEntry(x: 10.0, y: 22.0),
            ChartDataEntry(x: 11.0, y: 15.0)
        ]

        let dataSet = LineChartDataSet(entries: dataEntries, label: "Hart Rate")
        dataSet.colors = [UIColor.systemPink]

        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelTextColor = .black
        lineChartView.leftAxis.labelTextColor = .black
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = true
        
    }
    
    

}
extension DetailsHartRateVC {
    
    func setUpUi(){
        
        lineChartView = LineChartView()
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineChartView)

        // Set up constraints
        NSLayoutConstraint.activate([
            lineChartView.topAnchor.constraint(equalTo: lblDay.bottomAnchor, constant: 10),
            lineChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lineChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lineChartView.heightAnchor.constraint(equalToConstant: 360)
        ])
        
        chartsManage()
        
    }
    
    func chartsManage(){
        let xAxis = lineChartView.xAxis
        let leftAxis = lineChartView.leftAxis
        let rightAxis = lineChartView.rightAxis
        let legend = lineChartView.legend
        legend.enabled = false
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.granularityEnabled = true
        leftAxis.enabled = false
        xAxis.drawLabelsEnabled = true
        lineChartView.scaleYEnabled = false
        //lineChartView.zoomToCenter(scaleX: 2.5, scaleY: 0)
        
    }
    
    
}

extension DetailsHartRateVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return staticData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Static_Heart_TextCell", for: indexPath) as! Static_Heart_TextCell
            cell.lblTitle.text = "About Heart Rate"
            cell.lblDescrib.text = "Your heart beats approximately 100,000 times per day, accelerating and slowing through periods of rest and exertion. Your heart rate refers to how many times your heart beats per minute and can be an indicator of your cardiovascular health. \n \nHealth visualises a history of the heart rate data collected by Apple Watch or a heart rate monitor so you can see your patterns and variability over time and with different activities."
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Static_Heart_imgCell", for: indexPath) as! Static_Heart_imgCell
            cell.imgView.image = staticData[indexPath.row].img
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            
          return 250
            
        } else {
            
          return 250
            
        }
    }
    
}

