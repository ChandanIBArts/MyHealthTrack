//
//  HearingBarchatTVCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 14/03/24.
//

import UIKit
import DGCharts
import HealthKit

class HearingBarchatTVCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var cellChartView: UIView!
    
    var lineChartView = LineChartView()
    var hearingHealthKitManager = HearingHealthKitManager()

    var hearingData: [(Date, Double)] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUi()
        //fetchData()
        hearingHealthKitManager.requestAuthorization(for: [HKObjectType.categoryType(forIdentifier: .audioExposureEvent)!]) { (success, error) in
            if success {
                self.hearingHealthKitManager.fetchDailyHearingData { (hearingData) in
                    self.hearingData = hearingData
                    DispatchQueue.main.async {
                        if hearingData.count == 0 {
                            print("No Data Available")
                        } else {
                            self.updateChart()
                        }
        
                    }
                    print("Daily sleep data: \(hearingData)")
                }
            } else {
                print("Failed to authorize or error occurred: \(error?.localizedDescription ?? "")")
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
            hearingHealthKitManager.requestAuthorization(for: [HKObjectType.categoryType(forIdentifier: .audioExposureEvent)!]) { (success, error) in
                if success {
                    self.hearingHealthKitManager.fetchDailyHearingData { (hearingData) in
                        self.hearingData = hearingData
                        DispatchQueue.main.async {
                            if hearingData.count == 0 {
                                print("No Data Available")
                            } else {
                                self.updateChart()
                            }
                        }
                        print("Daily sleep data: \(hearingData)")
                    }
                } else {
                    print("Failed to authorize or error occurred: \(error?.localizedDescription ?? "")")
                }
            }
        case 1:
            hearingHealthKitManager.requestAuthorization(for: [HKObjectType.categoryType(forIdentifier: .audioExposureEvent)!]) { (success, error) in
                if success {
                    self.hearingHealthKitManager.fetchWeeklyHearingData{ (hearingData) in
                        self.hearingData = hearingData
                        DispatchQueue.main.async {
                            if hearingData.count == 0 {
                               print("No Data Available")
                            } else {
                                self.updateChart1()
                            }
                        }
                        print("Daily sleep data: \(hearingData)")
                    }
                } else {
                    print("Failed to authorize or error occurred: \(error?.localizedDescription ?? "")")
                }
            }
        case 2:
            hearingHealthKitManager.requestAuthorization(for: [HKObjectType.categoryType(forIdentifier: .audioExposureEvent)!]) { (success, error) in
                if success {
                    self.hearingHealthKitManager.fetchMonthlyHearingData { (hearingData) in
                        self.hearingData = hearingData
                        DispatchQueue.main.async {
                            if hearingData.count == 0 {
                                print("No Data Available")
                            } else {
                                self.updateChart2()
                            }
                        }
                        print("Daily sleep data: \(hearingData)")
                    }
                } else {
                    print("Failed to authorize or error occurred: \(error?.localizedDescription ?? "")")
                }
            }
        case 3:
            hearingHealthKitManager.requestAuthorization(for: [HKObjectType.categoryType(forIdentifier: .audioExposureEvent)!]) { (success, error) in
                if success {
                    self.hearingHealthKitManager.fetchHalfYearlyHearingData { (hearingData) in
                        self.hearingData = hearingData
                        DispatchQueue.main.async {
                            if hearingData.count == 0 {
                                print("No Data Available")
                            } else {
                                self.updateChart3()
                            }
                        }
                        print("Daily sleep data: \(hearingData)")
                    }
                } else {
                    print("Failed to authorize or error occurred: \(error?.localizedDescription ?? "")")
                }
            }
        case 4:
            hearingHealthKitManager.requestAuthorization(for: [HKObjectType.categoryType(forIdentifier: .audioExposureEvent)!]) { (success, error) in
                if success {
                    self.hearingHealthKitManager.fetchYearlyHearingData { (hearingData) in
                        self.hearingData = hearingData
                        DispatchQueue.main.async {
                            if hearingData.count == 0 {
                                print("No Data Available")
                            } else {
                                self.updateChart4()
                            }
                        }
                        print("Daily sleep data: \(hearingData)")
                    }
                } else {
                    print("Failed to authorize or error occurred: \(error?.localizedDescription ?? "")")
                }
            }
        default:
            break
        }
    }
    
  
   

}

extension HearingBarchatTVCell {
    
    func setUpUi(){
        cellView.layer.cornerRadius = 10
        cellView.clipsToBounds = true
        
        cellChartView.layer.borderColor = UIColor.systemMint.cgColor
        cellChartView.layer.borderWidth = 0.3
        
        lineChartView = LineChartView()
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        cellView.addSubview(lineChartView)

        // Set up constraints
        NSLayoutConstraint.activate([
            lineChartView.topAnchor.constraint(equalTo: cellChartView.topAnchor, constant: 10),
            lineChartView.leadingAnchor.constraint(equalTo: cellChartView.leadingAnchor, constant: 5),
            lineChartView.trailingAnchor.constraint(equalTo: cellChartView.trailingAnchor, constant: -5),
            lineChartView.bottomAnchor.constraint(equalTo: cellChartView.bottomAnchor, constant: -10)
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
    
    
    //MARK: Daily Hrs Data
    func updateChart() {
        //var count = 0
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in hearingData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
//            print(dataPoint.1)
//            dailyData = dailyData + Int(dataPoint.1)
//            count = index + index
            dataEntries.append(entry)
        }
        
//        if count == 0 {
//            self.lblData.text = "\(String(self.dailyData)) min"
//            dailyData = 0
//        } else {
//            self.lblData.text = "\(String(self.dailyData)) min"
//            dailyData = 0
//        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Hearing")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.systemCyan]
        chartDataSet.circleColors = [UIColor.green]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.cellChartView.addSubview(lineChart)
            lineChart.center = self.cellChartView.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            var time = [String]()
            
            time = dataEntries.map { entry in
                let date = Calendar.current.date(byAdding: .hour, value: Int(-entry.x), to: Date())!
                return dateFormatter.string(from: date)
            }
            time.reverse()
            self.lineChartView.xAxis.labelPosition = .bottom
            self.lineChartView.xAxis.labelTextColor = .black
            self.lineChartView.leftAxis.labelTextColor = .black
            self.lineChartView.rightAxis.enabled = false
            self.lineChartView.legend.enabled = true
            let xValuesFormatter = IndexAxisValueFormatter(values: time)
            self.lineChartView.xAxis.valueFormatter = xValuesFormatter
            self.lineChartView.xAxis.granularity = 1
            self.lineChartView.notifyDataSetChanged()
        }
    
    }
    
    
    //MARK: Weak Data
    func updateChart1() {
//        var count = 0
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in hearingData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
//            weeklyData = weeklyData + Int(dataPoint.1)
//            print(dataPoint.1)
//            count = index + index
            dataEntries.append(entry)
        }
//        if count == 0 {
//            self.lblData.text = "\(String(self.weeklyData)) min"
//            weeklyData = 0
//        } else {
//            self.lblData.text = "\(String(self.weeklyData)) min"
//            weeklyData = 0
//        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Hearing")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.systemCyan]
        chartDataSet.circleColors = [UIColor.green]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.cellChartView.addSubview(lineChart)
            lineChart.center = self.cellChartView.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
            var time = [String]()
            
            time = dataEntries.map { entry in
                let date = Calendar.current.date(byAdding: .day, value: Int(-entry.x), to: Date())!
                return dateFormatter.string(from: date)
            }
            time.reverse()
            self.lineChartView.xAxis.labelPosition = .bottom
            self.lineChartView.xAxis.labelTextColor = .black
            self.lineChartView.leftAxis.labelTextColor = .black
            self.lineChartView.rightAxis.enabled = false
            self.lineChartView.legend.enabled = true
            let xValuesFormatter = IndexAxisValueFormatter(values: time)
            self.lineChartView.xAxis.valueFormatter = xValuesFormatter
            self.lineChartView.xAxis.granularity = 1
            self.lineChartView.notifyDataSetChanged()
        }
        
    
    }
    
    
    //MARK: Monthly Data
    func updateChart2() {
    
//        var count = 0
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in hearingData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
//            monthlyData = monthlyData + Int(dataPoint.1)
//            print(dataPoint.1)
//            count = index + index
            dataEntries.append(entry)
        }
//        if count == 0 {
//            self.lblData.text = "\(String(self.monthlyData)) min"
//            monthlyData = 0
//        } else {
//            self.lblData.text = "\(String(self.monthlyData)) min"
//            monthlyData = 0
//        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Hearing")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.systemCyan]
        chartDataSet.circleColors = [UIColor.green]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.cellChartView.addSubview(lineChart)
            lineChart.center = self.cellChartView.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d"
            var time = [String]()
            
            time = dataEntries.map { entry in
                let date = Calendar.current.date(byAdding: .day, value: Int(-entry.x), to: Date())!
                return dateFormatter.string(from: date)
            }
            time.reverse()
            self.lineChartView.xAxis.labelPosition = .bottom
            self.lineChartView.xAxis.labelTextColor = .black
            self.lineChartView.leftAxis.labelTextColor = .black
            self.lineChartView.rightAxis.enabled = false
            self.lineChartView.legend.enabled = true
            let xValuesFormatter = IndexAxisValueFormatter(values: time)
            self.lineChartView.xAxis.valueFormatter = xValuesFormatter
            self.lineChartView.xAxis.granularity = 1
            self.lineChartView.notifyDataSetChanged()
        }
  
    }
    
    
    //MARK: HalfYearly Data
    func updateChart3() {
       // var count = 0
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in hearingData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
//            halfYearlyData = halfYearlyData + Int(dataPoint.1)
//            print(dataPoint.1)
//            count = index + index
            dataEntries.append(entry)
        }
//        if count == 0 {
//            self.lblData.text = "\(String(self.halfYearlyData)) min"
//            halfYearlyData = 0
//        } else {
//            self.lblData.text = "\(String(self.halfYearlyData)) min"
//            halfYearlyData = 0
//        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Hearing")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.systemCyan]
        chartDataSet.circleColors = [UIColor.green]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.cellChartView.addSubview(lineChart)
            lineChart.center = self.cellChartView.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            var time = [String]()
            
            time = dataEntries.map { entry in
                let date = Calendar.current.date(byAdding: .month, value: Int(-entry.x), to: Date())!
                return dateFormatter.string(from: date)
            }
            time.reverse()
            self.lineChartView.xAxis.labelPosition = .bottom
            self.lineChartView.xAxis.labelTextColor = .black
            self.lineChartView.leftAxis.labelTextColor = .black
            self.lineChartView.rightAxis.enabled = false
            self.lineChartView.legend.enabled = true
            let xValuesFormatter = IndexAxisValueFormatter(values: time)
            self.lineChartView.xAxis.valueFormatter = xValuesFormatter
            self.lineChartView.xAxis.granularity = 1
            self.lineChartView.notifyDataSetChanged()
        }
    
    }
    
    
    //MARK: Yearly Data
    func updateChart4() {
       // var count = 0
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in hearingData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
//            halfYearlyData = halfYearlyData + Int(dataPoint.1)
//            print(dataPoint.1)
//            count = index + index
            dataEntries.append(entry)
        }
//        if count == 0 {
//            self.lblData.text = "\(String(self.halfYearlyData)) min"
//            halfYearlyData = 0
//        } else {
//            self.lblData.text = "\(String(self.halfYearlyData)) min"
//            halfYearlyData = 0
//        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Hearing")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.systemCyan]
        chartDataSet.circleColors = [UIColor.green]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.cellChartView.addSubview(lineChart)
            lineChart.center = self.cellChartView.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            var time = [String]()
            
            time = dataEntries.map { entry in
                let date = Calendar.current.date(byAdding: .month, value: Int(-entry.x), to: Date())!
                return dateFormatter.string(from: date)
            }
            time.reverse()
            self.lineChartView.xAxis.labelPosition = .bottom
            self.lineChartView.xAxis.labelTextColor = .black
            self.lineChartView.leftAxis.labelTextColor = .black
            self.lineChartView.rightAxis.enabled = false
            self.lineChartView.legend.enabled = true
            let xValuesFormatter = IndexAxisValueFormatter(values: time)
            self.lineChartView.xAxis.valueFormatter = xValuesFormatter
            self.lineChartView.xAxis.granularity = 1
            self.lineChartView.notifyDataSetChanged()
        }
    
    }
    
}
