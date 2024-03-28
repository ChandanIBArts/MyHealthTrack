//
//  HeartRateChartTVCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 15/03/24.
//

import UIKit
import DGCharts
import HealthKit

class HeartRateChartTVCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var lblAverage: UILabel!
    
    let healthStore = HKHealthStore()
    let heartRateManager = HeartRateHealthKitManager()
    var lineChartView = LineChartView()
    
    //Average Heart Rate
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUi()
        heartRateManager.requestAuthorization(for: [HKObjectType.quantityType(forIdentifier: .heartRate)!]) {
            (success, error) in
            if success {
                self.heartRateManager.fetchHoursHeartRateData{ (heartRateData) in
                    DispatchQueue.main.async {
                        self.updateLineChart(with: heartRateData)
                        if heartRateData.count == 0 {
                            self.lblData.text = "0 bpm"
                            self.lblDay.text = ""
                            self.lblAverage.text = ""
                        } else {
                            for (index, dataPoint) in heartRateData.enumerated() {
                                self.lblData.text = "\(String(format: "%.0f",dataPoint.1)) bpm"
                                self.last1Hrs()
                                self.lblAverage.text = ""
                            }
                        }
                    }
                    
                }
               
            } else {
                print("Faild to authorize")
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
            heartRateManager.requestAuthorization(for: [HKObjectType.quantityType(forIdentifier: .heartRate)!]) {
                (success, error) in
                if success {
                    self.heartRateManager.fetchHoursHeartRateData{ (heartRateData) in
                        DispatchQueue.main.async {
                            self.updateLineChart(with: heartRateData)
                            if heartRateData.count == 0 {
                                self.lblData.text = "0 bpm"
                                self.lblDay.text = ""
                                self.lblAverage.text = ""
                            } else {
                                for (index, dataPoint) in heartRateData.enumerated() {
                                    self.lblData.text = "\(String(format: "%.0f",dataPoint.1)) bpm"
                                    self.last1Hrs()
                                    self.lblAverage.text = ""
                                }
                            }
                        }
                        
                    }
                   
                } else {
                    print("Faild to authorize")
                }
            }
            
        case 1:
            heartRateManager.requestAuthorization(for: [HKObjectType.quantityType(forIdentifier: .heartRate)!]) {
                (success, error) in
                if success {
                    self.heartRateManager.fetchDailyHeartRateData{ (heartRateData) in
                        DispatchQueue.main.async {
                            self.updateLineChart1(with: heartRateData)
                            if heartRateData.count == 0 {
                                self.lblData.text = "0 bpm"
                                self.lblDay.text = ""
                                self.lblAverage.text = ""
                            } else {
                                for (index, dataPoint) in heartRateData.enumerated() {
                                    self.lblData.text = "\(String(format: "%.0f",dataPoint.1)) bpm"
                                    self.lastDay()
                                    self.lblAverage.text = ""
                                }
                            }
                        }
                        
                    }
                   
                } else {
                    print("Faild to authorize")
                }
            }
        case 2:
            heartRateManager.requestAuthorization(for: [HKObjectType.quantityType(forIdentifier: .heartRate)!]) {
                (success, error) in
                if success {
                    self.heartRateManager.fetchWeeklyHeartRateData{ (heartRateData) in
                        DispatchQueue.main.async {
                            self.updateLineChart2(with: heartRateData)
                            if heartRateData.count == 0 {
                                self.lblData.text = "0 bpm"
                                self.lblDay.text = ""
                                self.lblAverage.text = ""
                            } else {
                                for (index, dataPoint) in heartRateData.enumerated() {
                                    self.lblData.text = "\(String(format: "%.0f",dataPoint.1)) bpm"
                                    self.lastWeek()
                                    self.lblAverage.text = ""
                                }
                            }
                        }
                        
                    }
                   
                } else {
                    print("Faild to authorize")
                }
            }
        case 3:
            heartRateManager.requestAuthorization(for: [HKObjectType.quantityType(forIdentifier: .heartRate)!]) {
                (success, error) in
                if success {
                    self.heartRateManager.fetchMonthlyHeartRateData{ (heartRateData) in
                        DispatchQueue.main.async {
                            self.updateLineChart3(with: heartRateData)
                            if heartRateData.count == 0 {
                                self.lblData.text = "0 bpm"
                                self.lblDay.text = ""
                                self.lblAverage.text = ""
                            } else {
                                for (index, dataPoint) in heartRateData.enumerated() {
                                    self.lblData.text = "\(String(format: "%.0f",dataPoint.1)) bpm"
                                    self.lastMonth()
                                    self.lblAverage.text = "Average"
                                }
                            }
                        }
                        
                    }
                   
                } else {
                    print("Faild to authorize")
                }
            }
        case 4:
            heartRateManager.requestAuthorization(for: [HKObjectType.quantityType(forIdentifier: .heartRate)!]) {
                (success, error) in
                if success {
                    self.heartRateManager.fetchHalfYearlyHeartRateData{ (heartRateData) in
                        DispatchQueue.main.async {
                            self.updateLineChart4(with: heartRateData)
                            if heartRateData.count == 0 {
                                self.lblData.text = "0 bpm"
                                self.lblDay.text = ""
                                self.lblAverage.text = ""
                            } else {
                                for (index, dataPoint) in heartRateData.enumerated() {
                                    self.lblData.text = "\(String(format: "%.0f",dataPoint.1)) bpm"
                                    self.last6Month()
                                    self.lblAverage.text = "Average"
                                }
                            }
                        }
                        
                    }
                   
                } else {
                    print("Faild to authorize")
                }
            }
        case 5:
            heartRateManager.requestAuthorization(for: [HKObjectType.quantityType(forIdentifier: .heartRate)!]) {
                (success, error) in
                if success {
                    self.heartRateManager.fetchYearlyHeartRateData{ (heartRateData) in
                        DispatchQueue.main.async {
                            self.updateLineChart5(with: heartRateData)
                            if heartRateData.count == 0 {
                                self.lblData.text = "0 bpm"
                                self.lblDay.text = ""
                                self.lblAverage.text = ""
                            } else {
                                for (index, dataPoint) in heartRateData.enumerated() {
                                    self.lblData.text = "\(String(format: "%.0f",dataPoint.1)) bpm"
                                    self.lastYear()
                                    self.lblAverage.text = "Average"
                                }
                            }
                        }
                        
                    }
                   
                } else {
                    print("Faild to authorize")
                }
            }
        default:
            break
        }
    }
   

    func setUpUi(){
        
        lineChartView = LineChartView()
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.addSubview(lineChartView)
        chartView.layer.borderColor = UIColor.systemPink.cgColor
        chartView.layer.borderWidth = 0.2

        // Set up constraints
        NSLayoutConstraint.activate([
            lineChartView.topAnchor.constraint(equalTo: chartView.topAnchor, constant: 10),
            lineChartView.leadingAnchor.constraint(equalTo: chartView.leadingAnchor, constant: 5),
            lineChartView.trailingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: -5),
            lineChartView.bottomAnchor.constraint(equalTo: chartView.bottomAnchor, constant: -5)
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
    }
    
    //MARK: PerHours Data
    func updateLineChart(with data: [(Date, Double)]) {
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in data.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            dataEntries.append(entry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Heart Rate")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.systemPink]
        chartDataSet.circleColors = [UIColor.systemPink]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.chartView.addSubview(lineChart)
            lineChart.center = self.chartView.center
            
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
    
    func last1Hrs(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"

        let calendar = Calendar.current
        let currentDate = Date()
        let startDate = calendar.date(bySettingHour: 15, minute: 0, second: 0, of: currentDate)!
        let endDate = calendar.date(bySettingHour: 16, minute: 0, second: 0, of: currentDate)!

        let startTime = dateFormatter.string(from: startDate)
        let endTime = dateFormatter.string(from: endDate)

        let formattedTime = "Today \(startTime) - \(endTime)"
        lblDay.text = formattedTime
        
    }
    
    
    //MARK: Daily Data
    func updateLineChart1(with data: [(Date, Double)]) {
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in data.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            dataEntries.append(entry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Heart Rate")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.systemPink]
        chartDataSet.circleColors = [UIColor.systemPink]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.chartView.addSubview(lineChart)
            lineChart.center = self.chartView.center
            
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
    
    func lastDay(){
        func formatDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, dd MMM yyyy"
            let dateString = dateFormatter.string(from: Date())
            return dateString
        }
        lblDay.text = formatDate()
    }
    
    //MARK: Weekly Data
    func updateLineChart2(with data: [(Date, Double)]) {
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in data.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            dataEntries.append(entry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Heart Rate")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.systemPink]
        chartDataSet.circleColors = [UIColor.systemPink]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.chartView.addSubview(lineChart)
            lineChart.center = self.chartView.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
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
    
    func lastWeek(){
        func getLastWeekDates() -> (startDate: Date, endDate: Date) {
            let calendar = Calendar.current
            let endDate = calendar.startOfDay(for: Date())
            let startDate = calendar.date(byAdding: .day, value: -6, to: endDate)!
            return (startDate, endDate)
        }

        func StartDateFormat(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd"
            return dateFormatter.string(from: date)
        }
        
        func formatDate(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            return dateFormatter.string(from: date)
        }

        let (startDate, endDate) = getLastWeekDates()
        let formattedStartDate = StartDateFormat(date: startDate)
        let formattedEndDate = formatDate(date: endDate)

        lblDay.text = "\(formattedStartDate) - \(formattedEndDate)"
    }
        
    //MARK: Monthly Data
    func updateLineChart3(with data: [(Date, Double)]) {
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in data.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            dataEntries.append(entry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Heart Rate")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.systemPink]
        chartDataSet.circleColors = [UIColor.systemPink]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.chartView.addSubview(lineChart)
            lineChart.center = self.chartView.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d"
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
    
    func lastMonth(){
        
        func getLastWeekDates() -> (startDate: Date, endDate: Date) {
            let calendar = Calendar.current
            let endDate = calendar.startOfDay(for: Date())
            let startDate = calendar.date(byAdding: .day, value: -30, to: endDate)!
            return (startDate, endDate)
        }

        func StartDateFormat(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM"
            return dateFormatter.string(from: date)
        }
        
        func formatDate(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            return dateFormatter.string(from: date)
        }

        let (startDate, endDate) = getLastWeekDates()
        let formattedStartDate = StartDateFormat(date: startDate)
        let formattedEndDate = formatDate(date: endDate)

        lblDay.text = "\(formattedStartDate) - \(formattedEndDate)"
        
    }
    
    //MARK: HalfYearly Data
    func updateLineChart4(with data: [(Date, Double)]) {
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in data.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            dataEntries.append(entry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Heart Rate")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.systemPink]
        chartDataSet.circleColors = [UIColor.systemPink]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.chartView.addSubview(lineChart)
            lineChart.center = self.chartView.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
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
    
    func last6Month(){
        func getLastWeekDates() -> (startDate: Date, endDate: Date) {
            let calendar = Calendar.current
            let endDate = calendar.startOfDay(for: Date())
            let startDate = calendar.date(byAdding: .month, value: -6, to: endDate)!
            return (startDate, endDate)
        }

    
        func formatDate(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            return dateFormatter.string(from: date)
        }

        let (startDate, endDate) = getLastWeekDates()
        let formattedStartDate = formatDate(date: startDate)
        let formattedEndDate = formatDate(date: endDate)

        lblDay.text = "\(formattedStartDate) - \(formattedEndDate)"
    }
    
    //MARK: Yearly Data
    func updateLineChart5(with data: [(Date, Double)]) {
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in data.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            dataEntries.append(entry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Heart Rate")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.systemPink]
        chartDataSet.circleColors = [UIColor.systemPink]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.chartView.addSubview(lineChart)
            lineChart.center = self.chartView.center
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
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
    
    func lastYear(){
        func getLastWeekDates() -> (startDate: Date, endDate: Date) {
            let calendar = Calendar.current
            let endDate = calendar.startOfDay(for: Date())
            let startDate = calendar.date(byAdding: .year, value: -1, to: endDate)!
            return (startDate, endDate)
        }

    
        func formatDate(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            return dateFormatter.string(from: date)
        }

        let (startDate, endDate) = getLastWeekDates()
        let formattedStartDate = formatDate(date: startDate)
        let formattedEndDate = formatDate(date: endDate)

        lblDay.text = "\(formattedStartDate) - \(formattedEndDate)"
        
    }
    
    
}
