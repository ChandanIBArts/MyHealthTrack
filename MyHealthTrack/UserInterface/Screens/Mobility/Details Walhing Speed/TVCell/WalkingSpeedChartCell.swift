//
//  WalkingSpeedChartCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 18/03/24.
//

import UIKit
import DGCharts
import HealthKit

class WalkingSpeedChartCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    
    
    var dailyTotalCount = 0.0
    var weeklyTotalCount = 0.0
    var monthlyTotalCount = 0.0
    var halfYearlyTotalCount = 0.0
    var yearlyTotalCount = 0.0
    
    let healthKitManager = DetailsWalkingSpeedHealthKitManager()
    var barChartView = BarChartView()
    var dailyWalkingSpeedData: [(Date, Double)] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUi()
        
        lblTotal.text = "TOTAL"
        lblDay.text = "Today"
        let typesToRead: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .walkingSpeed)!]
        healthKitManager.requestAuthorization(for: typesToRead) { [weak self] (success, error) in
            guard let self = self else { return }
            if success {
                self.healthKitManager.fetchDailyWalkingSpeed { (dailyData) in
                    self.dailyWalkingSpeedData = dailyData
                    DispatchQueue.main.async {
                        self.updateBarChart()
                        self.lblData.text = "\(String(format: "%.2f", self.dailyTotalCount))" //"\(MobilityHealthKitManager.todayWalkingSpeed!) KM/H"
                    }
                }
            } else {
                if let error = error {
                    print("Error requesting authorization: \(error.localizedDescription)")
                } else {
                    print("Authorization denied.")
                }
            }
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func segmentBar(_ sender: UISegmentedControl) {
        
        switch segmentBar.selectedSegmentIndex {
            
        case 0:
            //MARK: Daily Hrs Data
            lblTotal.text = "TOTAL"
            lblDay.text = "Today"
            let typesToRead: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .walkingSpeed)!]
            healthKitManager.requestAuthorization(for: typesToRead) { [weak self] (success, error) in
                guard let self = self else { return }
                if success {
                    self.healthKitManager.fetchDailyWalkingSpeed { (dailyData) in
                        self.dailyWalkingSpeedData = dailyData
                        DispatchQueue.main.async {
                            self.updateBarChart()
                            self.lblData.text = "\(String(format: "%.2f", self.dailyTotalCount))" // "\(MobilityHealthKitManager.todayWalkingSpeed!) KM/H"
                            self.dailyTotalCount = 0
                            
                        }
                    }
                } else {
                    if let error = error {
                        print("Error requesting authorization: \(error.localizedDescription)")
                    } else {
                        print("Authorization denied.")
                    }
                }
            }
        case 1:
            //MARK: Weak Data
            lblTotal.text = "AVERAGE"
            lblDay.text = "Last 7 Day"
            let typesToRead: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .walkingSpeed)!]
            healthKitManager.requestAuthorization(for: typesToRead) { [weak self] (success, error) in
                guard let self = self else { return }
                if success {
                    self.healthKitManager.fetchWeeklyWalkingSpeed{ (dailyData) in
                        self.dailyWalkingSpeedData = dailyData
                        DispatchQueue.main.async {
                            self.updateBarChart1()
                            self.lblData.text = "\(String(format: "%.2f", self.weeklyTotalCount/7)) KM/H"//"\(String(self.weeklyTotalCount/7)) KM/H"
                            self.weeklyTotalCount = 0
                        }
                    }
                } else {
                    if let error = error {
                        print("Error requesting authorization: \(error.localizedDescription)")
                    } else {
                        print("Authorization denied.")
                    }
                }
            }
        case 2:
            //MARK: Monthly Data
            lblTotal.text = "AVERAGE"
            lblDay.text = "Last 30 Day"
            let typesToRead: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .walkingSpeed)!]
            healthKitManager.requestAuthorization(for: typesToRead) { [weak self] (success, error) in
                guard let self = self else { return }
                if success {
                    self.healthKitManager.fetchMonthlyWalkingSpeed { (dailyData) in
                        self.dailyWalkingSpeedData = dailyData
                        DispatchQueue.main.async {
                            self.updateBarChart2()
                            self.lblData.text = "\(String(format: "%.2f", self.monthlyTotalCount/30)) KM/H"
                            self.monthlyTotalCount = 0
                        }
                    }
                } else {
                    if let error = error {
                        print("Error requesting authorization: \(error.localizedDescription)")
                    } else {
                        print("Authorization denied.")
                    }
                }
            }
        case 3:
            //MARK: HalfYearly Data
            lblTotal.text = "DAILY AVERAGE"
            lblDay.text = "Last 6 Month"
            let typesToRead: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .walkingSpeed)!]
            healthKitManager.requestAuthorization(for: typesToRead) { [weak self] (success, error) in
                guard let self = self else { return }
                if success {
                    self.healthKitManager.fetchHalfYearlyWalkingSpeed { (dailyData) in
                        self.dailyWalkingSpeedData = dailyData
                        DispatchQueue.main.async {
                            self.updateBarChart3()
                            self.lblData.text = "\(String(format: "%.2f", self.halfYearlyTotalCount/180)) KM/H"
                            self.halfYearlyTotalCount = 0
                        }
                    }
                } else {
                    if let error = error {
                        print("Error requesting authorization: \(error.localizedDescription)")
                    } else {
                        print("Authorization denied.")
                    }
                }
            }
        case 4:
            //MARK: Yearly Data
            lblTotal.text = "DAILY AVERAGE"
            lblDay.text = "Last 1 Year"
            let typesToRead: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .walkingSpeed)!]
            healthKitManager.requestAuthorization(for: typesToRead) { [weak self] (success, error) in
                guard let self = self else { return }
                if success {
                    self.healthKitManager.fetchYearlyWalkingSpeed { (dailyData) in
                        self.dailyWalkingSpeedData = dailyData
                        DispatchQueue.main.async {
                            self.updateBarChart4()
                            self.lblData.text = "\(String(format: "%.2f", self.yearlyTotalCount/360)) KM/H"
                            self.yearlyTotalCount = 0
                        }
                    }
                } else {
                    if let error = error {
                        print("Error requesting authorization: \(error.localizedDescription)")
                    } else {
                        print("Authorization denied.")
                    }
                }
            }
        default:
            break
            
        }
        
    }
    
    
    //MARK: Daily Hrs Data
    func updateBarChart() {
        var dataEntries: [BarChartDataEntry] = []
        for (index, dataPoint) in dailyWalkingSpeedData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            dailyTotalCount = dailyTotalCount + Double(dataPoint.1)
            dataEntries.append(entry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Walking Speed")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartDataSet.colors = [NSUIColor(cgColor: UIColor(red: 237.0/255.0, green: 127.0/255.0, blue: 51.0/255.0, alpha: 1.0).cgColor)]
        barChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let barChart = barChartView
        DispatchQueue.main.async {
            self.barChartView.data = chartData
            self.cellView.addSubview(barChart)
            barChart.center = self.cellView.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            var time = [String]()
            
            time = dataEntries.map { entry in
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
    func updateBarChart1() {
        var dataEntries: [BarChartDataEntry] = []
        for (index, dataPoint) in dailyWalkingSpeedData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            weeklyTotalCount = weeklyTotalCount + Double(dataPoint.1)
            dataEntries.append(entry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Walking Speed")
        chartDataSet.colors = [NSUIColor(cgColor: UIColor(red: 237.0/255.0, green: 127.0/255.0, blue: 51.0/255.0, alpha: 1.0).cgColor)]
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        
        let barChart = barChartView
        DispatchQueue.main.async {
            self.barChartView.data = chartData
            self.cellView.addSubview(barChart)
            barChart.center = self.cellView.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
            var time = [String]()
            
            time = dataEntries.map { entry in
                let date = Calendar.current.date(byAdding: .day, value: Int(-entry.x), to: Date())!
                return dateFormatter.string(from: date)
            }
            time.reverse()
            let xValuesFormatter = IndexAxisValueFormatter(values: time)
            self.barChartView.xAxis.valueFormatter = xValuesFormatter
            self.barChartView.xAxis.granularity = 1
            self.barChartView.notifyDataSetChanged()
        }
    
    }
    
    //MARK: Monthly Data
    func updateBarChart2() {
        var dataEntries: [BarChartDataEntry] = []
        for (index, dataPoint) in dailyWalkingSpeedData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            monthlyTotalCount = monthlyTotalCount + Double(dataPoint.1)
            dataEntries.append(entry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Walking Speed")
        chartDataSet.colors = [NSUIColor(cgColor: UIColor(red: 237.0/255.0, green: 127.0/255.0, blue: 51.0/255.0, alpha: 1.0).cgColor)]
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        
        let barChart = barChartView
        DispatchQueue.main.async {
            self.barChartView.data = chartData
            self.cellView.addSubview(barChart)
            barChart.center = self.cellView.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d"
            var time = [String]()
            
            time = dataEntries.map { entry in
                let date = Calendar.current.date(byAdding: .day, value: Int(-entry.x), to: Date())!
                return dateFormatter.string(from: date)
            }
            time.reverse()
            let xValuesFormatter = IndexAxisValueFormatter(values: time)
            self.barChartView.xAxis.valueFormatter = xValuesFormatter
            self.barChartView.xAxis.granularity = 1
            self.barChartView.notifyDataSetChanged()
        }
    
    }
    
    //MARK: HalfYearly Data
    func updateBarChart3() {
        var dataEntries: [BarChartDataEntry] = []
        for (index, dataPoint) in dailyWalkingSpeedData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            halfYearlyTotalCount = halfYearlyTotalCount + Double(dataPoint.1)
            dataEntries.append(entry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Walking Speed")
        chartDataSet.colors = [NSUIColor(cgColor: UIColor(red: 237.0/255.0, green: 127.0/255.0, blue: 51.0/255.0, alpha: 1.0).cgColor)]
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        
        let barChart = barChartView
        DispatchQueue.main.async {
            self.barChartView.data = chartData
            self.cellView.addSubview(barChart)
            barChart.center = self.cellView.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            var time = [String]()
            
            time = dataEntries.map { entry in
                let date = Calendar.current.date(byAdding: .month, value: Int(-entry.x), to: Date())!
                return dateFormatter.string(from: date)
            }
            time.reverse()
            let xValuesFormatter = IndexAxisValueFormatter(values: time)
            self.barChartView.xAxis.valueFormatter = xValuesFormatter
            self.barChartView.xAxis.granularity = 1
            self.barChartView.notifyDataSetChanged()
        }
    
    }
    
    //MARK: Yearly data
    func updateBarChart4() {
        var dataEntries: [BarChartDataEntry] = []
        for (index, dataPoint) in dailyWalkingSpeedData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            yearlyTotalCount = yearlyTotalCount + Double(dataPoint.1)
            dataEntries.append(entry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Walking Speed")
        chartDataSet.colors = [NSUIColor(cgColor: UIColor(red: 237.0/255.0, green: 127.0/255.0, blue: 51.0/255.0, alpha: 1.0).cgColor)]
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        
        let barChart = barChartView
        DispatchQueue.main.async {
            self.barChartView.data = chartData
            self.cellView.addSubview(barChart)
            barChart.center = self.cellView.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            var time = [String]()
            
            time = dataEntries.map { entry in
                let date = Calendar.current.date(byAdding: .month, value: Int(-entry.x), to: Date())!
                return dateFormatter.string(from: date)
            }
            time.reverse()
            let xValuesFormatter = IndexAxisValueFormatter(values: time)
            self.barChartView.xAxis.valueFormatter = xValuesFormatter
            self.barChartView.xAxis.granularity = 1
            self.barChartView.notifyDataSetChanged()
        }
    
    }
    
    func setUpUi(){
        cellView.layer.cornerRadius = 10
        cellView.clipsToBounds = true
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        cellView.addSubview(barChartView)
        // Set up constraints
        NSLayoutConstraint.activate([
            barChartView.topAnchor.constraint(equalTo: lblDay.bottomAnchor, constant: 5),
            barChartView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 5),
            barChartView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -5),
            barChartView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -5)
        ])
        
        chartsManage()
    }
    
    func chartsManage(){
        let xAxis = barChartView.xAxis
        let leftAxis = barChartView.leftAxis
        let rightAxis = barChartView.rightAxis
        let legend = barChartView.legend
        legend.enabled = false
        xAxis.labelPosition = .bottom
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.granularityEnabled = true
        leftAxis.enabled = false
        xAxis.drawLabelsEnabled = true
        barChartView.scaleYEnabled = false
        barChartView.zoomToCenter(scaleX: 2.5, scaleY: 0)
        
    }
    
    
}
