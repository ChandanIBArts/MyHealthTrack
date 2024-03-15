//
//  Walking+RunningDistanceVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 23/01/24.
//

import UIKit
import Charts
import DGCharts
import HealthKit

class Details_Walking_RunningDistanceVC: UIViewController {
    
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var dailyTotalCount: Float = 0.0
    var weeklyTotalCount: Float = 0.0
    var monthlyTotalCount: Float = 0.0
    var halfYearlyTotalCount: Float = 0.0
    var yearlyTotalCount: Float = 0.0
    
    let healthKitManager = DWRDHealthKitManager()
    var barChartView = BarChartView()
    var staticData = StaticModel.RWDModel
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        barChartView.frame = CGRect(x: 0, y: 0, width: Int(view.frame.size.width), height: Int(view.frame.size.width))
        barChartView.center = view.center
        chartsManage()
      
        //MARK: Daily Hrs Data
        healthKitManager.requestDailyAuthorization { success, _ in
            if success {
                self.healthKitManager.fetchDailyStepCount { walkingRunningData in
                    self.updateBarChart(with: walkingRunningData)
                    self.barChartView.xAxis.labelPosition = .bottom
                    DispatchQueue.main.async {
                        self.lblData.text =  "\(HealthKitmanager.dailyRunningAndWalkingDistance!) Km"
                        self.dailyTotalCount = 0
                    }
                }
            }
        }
        
    }
    
    
    
    
    @IBAction func tapBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func segmentBar(_ sender: UISegmentedControl) {
        
        switch segmentBar.selectedSegmentIndex {
        case 0:
            //MARK: Daily Hrs Data
            lblTotal.text = "TOTAL"
            lblDay.text = "Today"
            healthKitManager.requestDailyAuthorization { success, _ in
                if success {
                    self.healthKitManager.fetchDailyStepCount { walkingRunningData in
                        self.updateBarChart(with: walkingRunningData)
                        self.barChartView.xAxis.labelPosition = .bottom
                        DispatchQueue.main.async {
                            self.lblData.text =  "\(HealthKitmanager.dailyRunningAndWalkingDistance!) Km"
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
                    self.healthKitManager.fetchWeeklyStepCount { walkingRunningData in
                        self.updateBarChart1(with: walkingRunningData)
                        self.barChartView.xAxis.labelPosition = .bottom
                        DispatchQueue.main.async {
                            self.lblData.text = "\(String(format: "%.2f", (self.weeklyTotalCount/7))) Km"
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
                    self.healthKitManager.fetchMonthlyStepCount { walkingRunningData in
                        self.updateBarChart2(with: walkingRunningData)
                        self.barChartView.xAxis.labelPosition = .bottom
                        DispatchQueue.main.async {
                            self.lblData.text = "\(String(format: "%.2f", (self.monthlyTotalCount/30))) Km"
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
                    self.healthKitManager.fetchHalfYearlyStepCount { walkingRunningData in
                        self.updateBarChart3(with: walkingRunningData)
                        self.barChartView.xAxis.labelPosition = .bottom
                        DispatchQueue.main.async {
                            self.lblData.text = "\(String(format: "%.2f", (self.halfYearlyTotalCount/180))) Km"
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
                    self.healthKitManager.fetchYearlyStepCount { walkingRunningData in
                        self.updateBarChart4(with: walkingRunningData)
                        self.barChartView.xAxis.labelPosition = .bottom
                        DispatchQueue.main.async {
                            self.lblData.text = "\(String(format: "%.2f", (self.yearlyTotalCount/365))) Km"
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
    func updateBarChart(with walkingRunningData: [(Date, Double)]) {
        var entries: [BarChartDataEntry] = []
        for (index, data) in walkingRunningData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: data.1)
            dailyTotalCount = dailyTotalCount + Float(data.1)
            entries.append(entry)
        }
        let dataSet = BarChartDataSet(entries: entries, label: "Daily Walking + Running Distance")
        let data = BarChartData(dataSet: dataSet)
        
        let color = UIColor(red: 240.0/255.0, green: 201.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        let cgColor = color.cgColor
        let nsuicolor = NSUIColor(cgColor: cgColor)
        dataSet.colors = [nsuicolor]
        
        //dataSet.colors = [NSUIColor(cgColor: UIColor.red.cgColor)]
        dataSet.drawValuesEnabled = false
        let barChart = barChartView
        DispatchQueue.main.async {
            self.barChartView.data = data
            self.view.addSubview(barChart)
            barChart.center = self.view.center
            
            /*
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            let xValuesFormatter = IndexAxisValueFormatter(values: entries.map { dateFormatter.string(from: Calendar.current.date(byAdding: .hour, value: Int(-$0.x), to: Date())!) })
            */
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            var time = [String]()
            
            time = entries.map { entry in
                let date = Calendar.current.date(byAdding: .hour, value: Int(-entry.x), to: Date())!
                return dateFormatter.string(from: date)
            }
            time.reverse()
            let xValuesFormatter = IndexAxisValueFormatter(values: time)
            
            self.barChartView.xAxis.valueFormatter = xValuesFormatter
            self.barChartView.xAxis.granularity = 1
            self.barChartView.notifyDataSetChanged()
            
        }
  
    }
    
    //MARK: Weak Data
    func updateBarChart1(with walkingRunningData: [(Date, Double)]) {
        var entries: [BarChartDataEntry] = []
        for (index, data) in walkingRunningData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: data.1)
            weeklyTotalCount = weeklyTotalCount + Float(data.1)
            entries.append(entry)
        }
        let dataSet = BarChartDataSet(entries: entries, label: "Weekly Walking + Running Distance")
        let data = BarChartData(dataSet: dataSet)
        
        let color = UIColor(red: 240.0/255.0, green: 201.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        let cgColor = color.cgColor
        let nsuicolor = NSUIColor(cgColor: cgColor)
        dataSet.colors = [nsuicolor]
        
        //dataSet.colors = [NSUIColor(cgColor: UIColor.red.cgColor)]
        dataSet.drawValuesEnabled = false
        let barChart = barChartView
        DispatchQueue.main.async {
            self.barChartView.data = data
            self.view.addSubview(barChart)
            barChart.center = self.view.center
            /*
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let xValuesFormatter = IndexAxisValueFormatter(values: entries.map { dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: Int(-$0.x), to: Date())!) })
            */
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
            var dayName = [String]()
            
            dayName = entries.map { entry in
                let date = Calendar.current.date(byAdding: .day, value: Int(-entry.x), to: Date())!
                return dateFormatter.string(from: date)
            }
            dayName.reverse()
            let xValuesFormatter = IndexAxisValueFormatter(values: dayName)
            
            
            self.barChartView.xAxis.valueFormatter = xValuesFormatter
            self.barChartView.xAxis.granularity = 1
            self.barChartView.notifyDataSetChanged()
        }
  
    }
    
    //MARK: Monthly Data
    func updateBarChart2(with walkingRunningData: [(Date, Double)]) {
        var entries: [BarChartDataEntry] = []
        for (index, data) in walkingRunningData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: data.1)
            monthlyTotalCount = monthlyTotalCount + Float(data.1)
            entries.append(entry)
        }
        let dataSet = BarChartDataSet(entries: entries, label: "Monthly Walking + Running Distance")
        let data = BarChartData(dataSet: dataSet)
        
        let color = UIColor(red: 240.0/255.0, green: 201.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        let cgColor = color.cgColor
        let nsuicolor = NSUIColor(cgColor: cgColor)
        dataSet.colors = [nsuicolor]
        
        //dataSet.colors = [NSUIColor(cgColor: UIColor.red.cgColor)]
        dataSet.drawValuesEnabled = false
        let barChart = barChartView
        DispatchQueue.main.async {
            self.barChartView.data = data
            self.view.addSubview(barChart)
            barChart.center = self.view.center
            /*
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d"
            let xValuesFormatter = IndexAxisValueFormatter(values: entries.map { dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: Int(-$0.x), to: Date())!) })
            */
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d"
            var day = [String]()
            
            day = entries.map { entry in
                let date = Calendar.current.date(byAdding: .day, value: Int(-entry.x), to: Date())!
                return dateFormatter.string(from: date)
            }
            day.reverse()
            let xValuesFormatter = IndexAxisValueFormatter(values: day)
            
            
            self.barChartView.xAxis.valueFormatter = xValuesFormatter
            self.barChartView.xAxis.granularity = 1
            self.barChartView.notifyDataSetChanged()
            
        }
  
    }
    
   
    
    //MARK: HalfYearly Data
    func updateBarChart3(with walkingRunningData: [(Date, Double)]) {
        var entries: [BarChartDataEntry] = []
        for (index, data) in walkingRunningData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: data.1)
            print(data.1)
            halfYearlyTotalCount = halfYearlyTotalCount + Float(data.1)
            entries.append(entry)
        }
        let dataSet = BarChartDataSet(entries: entries, label: "Half Yearly Walking + Running Distance")
        let data = BarChartData(dataSet: dataSet)
        
        let color = UIColor(red: 240.0/255.0, green: 201.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        let cgColor = color.cgColor
        let nsuicolor = NSUIColor(cgColor: cgColor)
        dataSet.colors = [nsuicolor]
        
        //dataSet.colors = [NSUIColor(cgColor: UIColor.red.cgColor)]
        dataSet.drawValuesEnabled = false
        let barChart = barChartView
        DispatchQueue.main.async {
            self.barChartView.data = data
            self.view.addSubview(barChart)
            barChart.center = self.view.center
            
            /*
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM"
            let xValuesFormatter = IndexAxisValueFormatter(values: entries.map { dateFormatter.string(from: Calendar.current.date(byAdding: .month, value: Int(-$0.x), to: Date())!) })
            */
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            var monthNames = [String]()
            
            monthNames = entries.map { entry in
                let date = Calendar.current.date(byAdding: .month, value: Int(-entry.x), to: Date())!
                return dateFormatter.string(from: date)
            }
            monthNames.reverse()
            let xValuesFormatter = IndexAxisValueFormatter(values: monthNames)
            
            
            self.barChartView.xAxis.valueFormatter = xValuesFormatter
            self.barChartView.xAxis.granularity = 1
            self.barChartView.notifyDataSetChanged()
        }
  
    }
    

    //MARK: Yearly Data
    func updateBarChart4(with walkingRunningData: [(Date, Double)]) {
        var entries: [BarChartDataEntry] = []
        for (index, data) in walkingRunningData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: data.1)
            print(data.1)
            yearlyTotalCount = yearlyTotalCount + Float(data.1)
            entries.append(entry)
        }
        let dataSet = BarChartDataSet(entries: entries, label: "Yearly Walking + Running Distance")
        let data = BarChartData(dataSet: dataSet)
        
        let color = UIColor(red: 240.0/255.0, green: 201.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        let cgColor = color.cgColor
        let nsuicolor = NSUIColor(cgColor: cgColor)
        dataSet.colors = [nsuicolor]
        
        //dataSet.colors = [NSUIColor(cgColor: UIColor.red.cgColor)]
        dataSet.drawValuesEnabled = false
        let barChart = barChartView
        DispatchQueue.main.async {
            self.barChartView.data = data
            self.view.addSubview(barChart)
            barChart.center = self.view.center
            
            /*
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM"
            let xValuesFormatter = IndexAxisValueFormatter(values: entries.map { dateFormatter.string(from: Calendar.current.date(byAdding: .month, value: Int(-$0.x), to: Date())!) })
            */
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            var monthNames = [String]()
            
            monthNames = entries.map { entry in
                let date = Calendar.current.date(byAdding: .month, value: Int(-entry.x), to: Date())!
                return dateFormatter.string(from: date)
            }
            monthNames.reverse()
            let xValuesFormatter = IndexAxisValueFormatter(values: monthNames)
            
            self.barChartView.xAxis.valueFormatter = xValuesFormatter
            self.barChartView.xAxis.granularity = 1
            self.barChartView.notifyDataSetChanged()
        }
  
    }
 
}



extension Details_Walking_RunningDistanceVC {
    
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

extension Details_Walking_RunningDistanceVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staticData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RW_Static_Cell", for: indexPath) as! RW_Static_Cell
        cell.imgView.image = staticData[indexPath.row].img
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}



