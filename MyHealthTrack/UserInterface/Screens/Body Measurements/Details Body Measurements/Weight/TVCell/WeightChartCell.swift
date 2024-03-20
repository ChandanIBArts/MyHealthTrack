//
//  WeightChartCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 15/03/24.
//

import UIKit
import DGCharts
import HealthKit

class WeightChartCell: UITableViewCell {
    
    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var dataLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var cehartView: UIView!
    
    var dailyData = 0
    var weeklyData = 0
    var monthlyData = 0
    var halfYearlyData = 0
    var yearlyData = 0
    
    let healthKitManager = DetailsWeightKitManager()
    var lineChartView = LineChartView()
    var dailyWalkingSpeedData: [(Date, Double)] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUi()
        let typesToRead: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .bodyMass)!]
        healthKitManager.requestAuthorization(for: typesToRead) { [weak self] (success, error) in
            guard let self = self else { return }
            if success {
                self.healthKitManager.fetchDailyWalkingSpeed { (dailyData) in
                    self.dailyWalkingSpeedData = dailyData
                    DispatchQueue.main.async {
                        self.updateBarChart()
                        self.fetchTodayDate()
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
        //fetchData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func segmentBar(_ sender: UISegmentedControl) {
   
        switch segmentBar.selectedSegmentIndex {
            
        case 0:
            //MARK: Daily Hrs Data
            let typesToRead: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .bodyMass)!]
            healthKitManager.requestAuthorization(for: typesToRead) { [weak self] (success, error) in
                guard let self = self else { return }
                if success {
                    self.healthKitManager.fetchDailyWalkingSpeed { (dailyData) in
                        self.dailyWalkingSpeedData = dailyData
                        DispatchQueue.main.async {
                            self.updateBarChart()
                            self.updateBarChart()
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
            let typesToRead: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .bodyMass)!]
            healthKitManager.requestAuthorization(for: typesToRead) { [weak self] (success, error) in
                guard let self = self else { return }
                if success {
                    self.healthKitManager.fetchWeeklyWalkingSpeed{ (dailyData) in
                        self.dailyWalkingSpeedData = dailyData
                        print(dailyData)
                        DispatchQueue.main.async {
                            self.updateBarChart1()
                            self.fetchLastWeekDate()
                            self.weeklyData = 0
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
            let typesToRead: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .bodyMass)!]
            healthKitManager.requestAuthorization(for: typesToRead) { [weak self] (success, error) in
                guard let self = self else { return }
                if success {
                    self.healthKitManager.fetchMonthlyWalkingSpeed { (dailyData) in
                        self.dailyWalkingSpeedData = dailyData
                        DispatchQueue.main.async {
                            self.updateBarChart2()
                            self.fetchLastMonthDate()
                            self.monthlyData = 0
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
            let typesToRead: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .bodyMass)!]
            healthKitManager.requestAuthorization(for: typesToRead) { [weak self] (success, error) in
                guard let self = self else { return }
                if success {
                    self.healthKitManager.fetchHalfYearlyWalkingSpeed { (dailyData) in
                        self.dailyWalkingSpeedData = dailyData
                        DispatchQueue.main.async {
                            self.updateBarChart3()
                            self.fetch6MonthData()
                            self.halfYearlyData = 0
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
            let typesToRead: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .bodyMass)!]
            healthKitManager.requestAuthorization(for: typesToRead) { [weak self] (success, error) in
                guard let self = self else { return }
                if success {
                    self.healthKitManager.fetchYearlyWalkingSpeed { (dailyData) in
                        self.dailyWalkingSpeedData = dailyData
                        DispatchQueue.main.async {
                            self.updateBarChart4()
                            self.fetchYearlyData()
                            self.yearlyData = 0
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
        var count = 0
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in dailyWalkingSpeedData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            dailyData = dailyData + Int(Float(dataPoint.1))
            count = index + index
            dataEntries.append(entry)
        }
        
        if count == 0 {
            self.dataLbl.text = "\(String(self.dailyData)) Kg"
            dailyData = 0
        } else {
            self.dataLbl.text = "\(String(self.dailyData / count)) Kg"
            dailyData = 0
        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Weight")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.purple]
        chartDataSet.circleColors = [UIColor.purple]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.cehartView.addSubview(lineChart)
            lineChart.center = self.cehartView.center
            
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
    func updateBarChart1() {
        var count = 0
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in dailyWalkingSpeedData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            weeklyData = weeklyData + Int(dataPoint.1)
            count = index + index
            dataEntries.append(entry)
        }
        if count == 0 {
            self.dataLbl.text = "\(String(self.weeklyData)) Kg"
            weeklyData = 0
        } else {
            self.dataLbl.text = "\(String(self.weeklyData/count)) Kg"
            weeklyData = 0
        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Weight")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.purple]
        chartDataSet.circleColors = [UIColor.purple]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.cehartView.addSubview(lineChart)
            lineChart.center = self.cehartView.center
            
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
    func updateBarChart2() {
    
        var count = 0
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in dailyWalkingSpeedData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            monthlyData = monthlyData + Int(dataPoint.1)
            count = index + index
            dataEntries.append(entry)
        }
        if count == 0 {
            self.dataLbl.text = "\(String(self.monthlyData)) Kg"
            monthlyData = 0
        } else {
            self.dataLbl.text = "\(String(self.monthlyData/count)) Kg"
            monthlyData = 0
        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Weight")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.purple]
        chartDataSet.circleColors = [UIColor.purple]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.cehartView.addSubview(lineChart)
            lineChart.center = self.cehartView.center
            
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
    func updateBarChart3() {
        var count = 0
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in dailyWalkingSpeedData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            halfYearlyData = halfYearlyData + Int(dataPoint.1)
            count = index + index
            dataEntries.append(entry)
        }
        if count == 0 {
            self.dataLbl.text = "\(String(self.halfYearlyData)) Kg"
            halfYearlyData = 0
        } else {
            self.dataLbl.text = "\(String(self.halfYearlyData/count)) Kg"
            halfYearlyData = 0
        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Weight")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.purple]
        chartDataSet.circleColors = [UIColor.purple]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.cehartView.addSubview(lineChart)
            lineChart.center = self.cehartView.center
            
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
    func updateBarChart4() {
        
        var count = 0
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in dailyWalkingSpeedData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            yearlyData = yearlyData + Int(dataPoint.1)
            count = index + index
            dataEntries.append(entry)
        }
        if count == 0 {
            self.dataLbl.text = "\(String(self.yearlyData)) Kg"
            yearlyData = 0
        } else {
            self.dataLbl.text = "\(String(self.yearlyData/count)) Kg"
            yearlyData = 0
        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Weight")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.purple]
        chartDataSet.circleColors = [UIColor.purple]
        lineChartView.data = chartData
        chartDataSet.drawValuesEnabled = false
        let lineChart = lineChartView
        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.cehartView.addSubview(lineChart)
            lineChart.center = self.cehartView.center
            
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

    
    func setUpUi(){
        cellBackground.layer.cornerRadius = 10
        cellBackground.clipsToBounds = true
        cehartView.layer.borderColor = UIColor.purple.cgColor
        cehartView.layer.borderWidth = 0.2
        
        lineChartView = LineChartView()
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        cehartView.addSubview(lineChartView)
        lineChartView.layer.borderColor = UIColor.black.cgColor
        lineChartView.borderLineWidth = 1.0
        // Set up constraints
        NSLayoutConstraint.activate([
            lineChartView.topAnchor.constraint(equalTo: cehartView.topAnchor, constant: 5),
            lineChartView.leadingAnchor.constraint(equalTo: cehartView.leadingAnchor, constant: 5),
            lineChartView.trailingAnchor.constraint(equalTo: cehartView.trailingAnchor, constant: -5),
            lineChartView.bottomAnchor.constraint(equalTo: cehartView.bottomAnchor, constant: -5)
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
    
    
    func fetchTodayDate(){
        func formatDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, dd MMM yyyy"
            let dateString = dateFormatter.string(from: Date())
            return dateString
        }

        dateLbl.text = formatDate()
        
    }
    
    
    func fetchLastWeekDate(){
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

        dateLbl.text = "\(formattedStartDate) - \(formattedEndDate)"
    }
    
    
    func fetchLastMonthDate(){
        
        
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

        dateLbl.text = "\(formattedStartDate) - \(formattedEndDate)"
   
    }
    
    func fetch6MonthData(){
        
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

        dateLbl.text = "\(formattedStartDate) - \(formattedEndDate)"
        
        
    }
    
    func fetchYearlyData(){
        
        func getCurrentYear() -> Int {
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: Date())
            return currentYear
        }

        let currentYear = getCurrentYear()

        dateLbl.text = String(currentYear)
        
        
    }
    
}
