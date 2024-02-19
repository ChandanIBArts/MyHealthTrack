//
//  Details_StairsClimbedVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 25/01/24.
//

import UIKit
import Charts
import DGCharts
import HealthKit

class Details_StairsClimbedVC: UIViewController {
    
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    
    
    var dailyTotalCount = 0
    var weeklyTotalCount = 0
    var monthlyTotalCount = 0
    var halfYearlyTotalCount = 0
    var yearlyTotalCount = 0
    
    let healthKitManager = DetailsStairsClimbedHealthKitManager()
    
    var barChartView = BarChartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.frame = CGRect(x: 0, y: 0, width: Int(view.frame.size.width), height: Int(view.frame.size.width))
        barChartView.center = view.center
        chartsManage()
        
        //MARK: Daily Hrs Data
        healthKitManager.requestDailyAuthorization { success, _ in
            if success {
                self.healthKitManager.fetchDailyStepCount { stairClimbedStepCountData in
                    self.updateBarChart(with: stairClimbedStepCountData)
                    self.barChartView.xAxis.labelPosition = .bottom
                    DispatchQueue.main.async {
                        self.lblData.text = "\(HealthKitmanager.dailyStairClimbedStep!) Steps"
                        self.dailyTotalCount = 0
                    }
                }
            }
        }
        
    }
    
    @IBAction func btnTapBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func segmentBar(_ sender: UISegmentedControl) {
        
        switch segmentBar.selectedSegmentIndex {
        case 0:
            //MARK: Daily Hrs Data
            lblTotal.text = "TOTAL"
            lblDay.text = "Today"
            healthKitManager.requestDailyAuthorization { success, _ in
                if success {
                    self.healthKitManager.fetchDailyStepCount { stairClimbedStepCountData in
                        self.updateBarChart(with: stairClimbedStepCountData)
                        self.barChartView.xAxis.labelPosition = .bottom
                        DispatchQueue.main.async {
                            self.lblData.text = "\(HealthKitmanager.dailyStairClimbedStep!) Steps"
                            self.dailyTotalCount = 0
                        }
                    }
                }
            }
        case 1:
            //MARK: Weak Data
            lblTotal.text = "AVERAGE"
            lblDay.text = "Last 7 Day"
            healthKitManager.requestWeeklyAuthorization { success, _ in
                if success {
                    self.healthKitManager.fetchWeeklyStepCount { stairClimbedStepCountData in
                        self.updateBarChart1(with: stairClimbedStepCountData)
                        self.barChartView.xAxis.labelPosition = .bottom
                        DispatchQueue.main.async {
                            self.lblData.text = "\(String(self.weeklyTotalCount/7)) Steps"
                            self.weeklyTotalCount = 0
                        }
                    }
                }
            }
           
        case 2:
            //MARK: Monthly Data
            lblTotal.text = "AVERAGE"
            lblDay.text = "Last 30 Day"
            healthKitManager.requestMonthlyAuthorization { success, _ in
                if success {
                    self.healthKitManager.fetchMonthlyStepCount { stairClimbedStepCountData in
                        self.updateBarChart2(with: stairClimbedStepCountData)
                        self.barChartView.xAxis.labelPosition = .bottom
                        DispatchQueue.main.async {
                            self.lblData.text = "\(String(self.monthlyTotalCount/30)) Steps"
                            self.monthlyTotalCount = 0
                        }
                    }
                }
            }
            
        case 3:
            //MARK: HalfYearly Data
            lblTotal.text = "DAILY AVERAGE"
            lblDay.text = "Last 6 Month"
            healthKitManager.requestHalfYearlyAuthorization { success, _ in
                if success {
                    self.healthKitManager.fetchHalfYearlyStepCount { stairClimbedStepCountData in
                        self.updateBarChart3(with: stairClimbedStepCountData)
                        self.barChartView.xAxis.labelPosition = .bottom
                        DispatchQueue.main.async {
                            self.lblData.text = "\(String(self.halfYearlyTotalCount/180)) Steps"
                            self.halfYearlyTotalCount = 0
                        }
                    }
                }
            }
            
            
        case 4:
            //MARK: Yearly Data
            lblTotal.text = "DAILY AVERAGE"
            lblDay.text = "Last 1 Year"
            healthKitManager.requestYearlyAuthorization { success, _ in
                if success {
                    self.healthKitManager.fetchYearlyStepCount { stairClimbedStepCountData in
                        self.updateBarChart4(with: stairClimbedStepCountData)
                        self.barChartView.xAxis.labelPosition = .bottom
                        DispatchQueue.main.async {
                            self.lblData.text = "\(String(self.yearlyTotalCount/365)) Steps"
                            self.yearlyTotalCount = 0
                        }
                    }
                }
            }
            
            
            
        default:
            break
        }
    }
    
    @IBAction func btnAddData(_ sender: UIButton) {
        
        print("Hello World")
        
    }
    
    //MARK: Daily Hrs Data
    func updateBarChart(with stairClimbedStepCountData: [(Date, Double)]) {
        var entries: [BarChartDataEntry] = []
        for (index, data) in stairClimbedStepCountData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: data.1)
            dailyTotalCount = dailyTotalCount + Int(data.1)
            entries.append(entry)
        }
        let dataSet = BarChartDataSet(entries: entries, label: "Daily Stair Climbed Step Count")
        let data = BarChartData(dataSet: dataSet)
        dataSet.colors = [NSUIColor(cgColor: UIColor.red.cgColor)]
        dataSet.drawValuesEnabled = false
        let barChart = barChartView
        DispatchQueue.main.async {
            self.barChartView.data = data
            self.view.addSubview(barChart)
            barChart.center = self.view.center
            
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            let xValuesFormatter = IndexAxisValueFormatter(values: entries.map { dateFormatter.string(from: Calendar.current.date(byAdding: .hour, value: Int(-$0.x), to: Date())!) })
            self.barChartView.xAxis.valueFormatter = xValuesFormatter
            self.barChartView.xAxis.granularity = 1
            self.barChartView.notifyDataSetChanged()
        }
  
    }
    
    //MARK: Weak Data
    func updateBarChart1(with stairClimbedStepCountData: [(Date, Double)]) {
        var entries: [BarChartDataEntry] = []
        for (index, data) in stairClimbedStepCountData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: data.1)
            weeklyTotalCount = weeklyTotalCount + Int(data.1)
            entries.append(entry)
        }
        let dataSet = BarChartDataSet(entries: entries, label: "Weekly Stair Climbed Step Count")
        let data = BarChartData(dataSet: dataSet)
        dataSet.colors = [NSUIColor(cgColor: UIColor.red.cgColor)]
        dataSet.drawValuesEnabled = false
        let barChart = barChartView
        DispatchQueue.main.async {
            self.barChartView.data = data
            self.view.addSubview(barChart)
            barChart.center = self.view.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let xValuesFormatter = IndexAxisValueFormatter(values: entries.map { dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: Int(-$0.x), to: Date())!) })
            self.barChartView.xAxis.valueFormatter = xValuesFormatter
            self.barChartView.xAxis.granularity = 1
            self.barChartView.notifyDataSetChanged()
        }
  
    }
    
    //MARK: Monthly Data
    func updateBarChart2(with stairClimbedStepCountData: [(Date, Double)]) {
        var entries: [BarChartDataEntry] = []
        for (index, data) in stairClimbedStepCountData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: data.1)
            monthlyTotalCount = monthlyTotalCount + Int(data.1)
            entries.append(entry)
        }
        let dataSet = BarChartDataSet(entries: entries, label: "Monthly Stair Climbed Step Count")
        let data = BarChartData(dataSet: dataSet)
        dataSet.colors = [NSUIColor(cgColor: UIColor.red.cgColor)]
        dataSet.drawValuesEnabled = false
        let barChart = barChartView
        DispatchQueue.main.async {
            self.barChartView.data = data
            self.view.addSubview(barChart)
            barChart.center = self.view.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d"
            let xValuesFormatter = IndexAxisValueFormatter(values: entries.map { dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: Int(-$0.x), to: Date())!) })
            self.barChartView.xAxis.valueFormatter = xValuesFormatter
            self.barChartView.xAxis.granularity = 1
            self.barChartView.notifyDataSetChanged()
            
        }
  
    }
    
    
    //MARK: HalfYearly Data
    func updateBarChart3(with stairClimbedStepCountData: [(Date, Double)]) {
        var entries: [BarChartDataEntry] = []
        for (index, data) in stairClimbedStepCountData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: data.1)
            print(data.1)
            halfYearlyTotalCount = halfYearlyTotalCount + Int(data.1)
            entries.append(entry)
        }
        let dataSet = BarChartDataSet(entries: entries, label: "Yearly Stair Climbed Step Count")
        let data = BarChartData(dataSet: dataSet)
        dataSet.colors = [NSUIColor(cgColor: UIColor.red.cgColor)]
        dataSet.drawValuesEnabled = false
        let barChart = barChartView
        DispatchQueue.main.async {
            self.barChartView.data = data
            self.view.addSubview(barChart)
            barChart.center = self.view.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM"
            let xValuesFormatter = IndexAxisValueFormatter(values: entries.map { dateFormatter.string(from: Calendar.current.date(byAdding: .month, value: Int(-$0.x), to: Date())!) })
            self.barChartView.xAxis.valueFormatter = xValuesFormatter
            self.barChartView.xAxis.granularity = 1
            self.barChartView.notifyDataSetChanged()
        }
  
    }
    
    
    
    //MARK: Yearly Data
    func updateBarChart4(with stairClimbedStepCountData: [(Date, Double)]) {
        var entries: [BarChartDataEntry] = []
        for (index, data) in stairClimbedStepCountData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: data.1)
            print(data.1)
            yearlyTotalCount = yearlyTotalCount + Int(data.1)
            entries.append(entry)
        }
        let dataSet = BarChartDataSet(entries: entries, label: "Yearly Stair Climbed Step Count")
        let data = BarChartData(dataSet: dataSet)
        dataSet.colors = [NSUIColor(cgColor: UIColor.red.cgColor)]
        dataSet.drawValuesEnabled = false
        let barChart = barChartView
        DispatchQueue.main.async {
            self.barChartView.data = data
            self.view.addSubview(barChart)
            barChart.center = self.view.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM"
            let xValuesFormatter = IndexAxisValueFormatter(values: entries.map { dateFormatter.string(from: Calendar.current.date(byAdding: .month, value: Int(-$0.x), to: Date())!) })
            self.barChartView.xAxis.valueFormatter = xValuesFormatter
            self.barChartView.xAxis.granularity = 1
            self.barChartView.notifyDataSetChanged()
        }
  
    }
      
}

extension Details_StairsClimbedVC {
    
    func chartsManage(){
        
        let xAxis = barChartView.xAxis
        let leftAxis = barChartView.leftAxis
        let rightAxis = barChartView.rightAxis
        let legend = barChartView.legend
        legend.enabled = false
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.granularityEnabled = true
        leftAxis.enabled = false
        xAxis.drawLabelsEnabled = true
        barChartView.scaleYEnabled = false
        barChartView.zoomToCenter(scaleX: 2.5, scaleY: 0)
        
    }

}
