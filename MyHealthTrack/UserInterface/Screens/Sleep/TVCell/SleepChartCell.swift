//
//  SleepChartCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 15/03/24.
//

import UIKit
import DGCharts
import HealthKit

class SleepChartCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var lblUpdateDate: UILabel!
    @IBOutlet weak var btnTapQuestion: UIButton!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var lblData: UILabel!
    
    
    var dailyData = 0
    var weeklyData = 0
    var monthlyData = 0
    var halfYearlyData = 0
    
    var dailySleepData: [(Date, Double)] = []
    var weeklySleepData: [(Date, Double)] = []
    var monthlySleepData: [(Date, Double)] = []
    var halfyearlySleepData: [(Date, Double)] = []
    
    
    var lineChartView = LineChartView()
    var sleepHealthKitManager = SleepHealthKitManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUi()
        sleepHealthKitManager.requestAuthorization(for: [HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!]) { (success, error) in
            if success {
                self.sleepHealthKitManager.fetchDailySleepData { (sleepData) in
                    self.dailySleepData = sleepData
                    DispatchQueue.main.async {
                        self.updateBarChart()
                      //  self.fetchTodayDate()
                    }
                    print("Daily sleep data: \(sleepData)")
                }
            } else {
                print("Failed to authorize or error occurred: \(error?.localizedDescription ?? "")")
            }
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    
    @IBAction func segmentBar(_ sender: UISegmentedControl) {
        switch segmentBar.selectedSegmentIndex {
           
        case 0:
            sleepHealthKitManager.requestAuthorization(for: [HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!]) { (success, error) in
                if success {
                    self.sleepHealthKitManager.fetchDailySleepData { (sleepData) in
                        self.dailySleepData = sleepData
                        DispatchQueue.main.async {
                            self.updateBarChart()
                          //  self.fetchTodayDate()
                        }
                        print("Daily sleep data: \(sleepData)")
                    }
                } else {
                    print("Failed to authorize or error occurred: \(error?.localizedDescription ?? "")")
                }
            }
        case 1:
            sleepHealthKitManager.requestAuthorization(for: [HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!]) { (success, error) in
                if success {
                    self.sleepHealthKitManager.fetchWeeklySleepData { (sleepData) in
                        self.weeklySleepData = sleepData
                        DispatchQueue.main.async {
                            self.updateBarChart1()
                          //  self.fetchLastWeekDate()
                        }
                        print("Daily sleep data: \(sleepData)")
                    }
                } else {
                    print("Failed to authorize or error occurred: \(error?.localizedDescription ?? "")")
                }
            }
            
        case 2:
            sleepHealthKitManager.requestAuthorization(for: [HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!]) { (success, error) in
                if success {
                    self.sleepHealthKitManager.fetchMonthlySleepData { (sleepData) in
                        self.monthlySleepData = sleepData
                        DispatchQueue.main.async {
                            self.updateBarChart2()
                           // self.fetchLastMonthDate()
                        }
                        print("Daily sleep data: \(sleepData)")
                    }
                } else {
                    print("Failed to authorize or error occurred: \(error?.localizedDescription ?? "")")
                }
            }
        case 3:
            sleepHealthKitManager.requestAuthorization(for: [HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!]) { (success, error) in
                if success {
                    self.sleepHealthKitManager.fetchHalfYearlySleepData { (sleepData) in
                        self.halfyearlySleepData = sleepData
                        DispatchQueue.main.async {
                            self.updateBarChart3()
                          //  self.fetch6MonthData()
                        }
                        print("Daily sleep data: \(sleepData)")
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

extension SleepChartCell {
    func setUpUi(){
        chartView.layer.cornerRadius = 10
        chartView.clipsToBounds = true
        chartView.layer.borderColor = UIColor.systemMint.cgColor
        chartView.layer.borderWidth = 0.2
        
        lineChartView = LineChartView()
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.addSubview(lineChartView)
        lineChartView.layer.borderColor = UIColor.black.cgColor
        lineChartView.borderLineWidth = 1.0
        // Set up constraints
        NSLayoutConstraint.activate([
            lineChartView.topAnchor.constraint(equalTo: chartView.topAnchor, constant: 5),
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
    
    //MARK: Daily Hrs Data
    func updateBarChart() {
        var count = 0
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in dailySleepData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            print(dataPoint.1)
            dailyData = dailyData + Int(dataPoint.1)
            count = index + index
            dataEntries.append(entry)
        }
        
        if count == 0 {
            self.lblData.text = "\(String(self.dailyData)) min"
            dailyData = 0
        } else {
            self.lblData.text = "\(String(self.dailyData)) min"
            dailyData = 0
        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Sleep")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.systemMint]
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
    
    /*
    func fetchTodayDate(){
        func formatDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, dd MMM yyyy"
            let dateString = dateFormatter.string(from: Date())
            return dateString
        }
        lblUpdateDate.text = formatDate()
    }
    */
    
    //MARK: Weak Data
    func updateBarChart1() {
        var count = 0
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in weeklySleepData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            weeklyData = weeklyData + Int(dataPoint.1)
            print(dataPoint.1)
            count = index + index
            dataEntries.append(entry)
        }
        if count == 0 {
            self.lblData.text = "\(String(self.weeklyData)) min"
            weeklyData = 0
        } else {
            self.lblData.text = "\(String(self.weeklyData)) min"
            weeklyData = 0
        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Sleep")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.systemMint]
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
    
    /*
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

        lblUpdateDate.text = "\(formattedStartDate) - \(formattedEndDate)"
    }
    */
    
    //MARK: Monthly Data
    func updateBarChart2() {
    
        var count = 0
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in monthlySleepData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            monthlyData = monthlyData + Int(dataPoint.1)
            print(dataPoint.1)
            count = index + index
            dataEntries.append(entry)
        }
        if count == 0 {
            self.lblData.text = "\(String(self.monthlyData)) min"
            monthlyData = 0
        } else {
            self.lblData.text = "\(String(self.monthlyData)) min"
            monthlyData = 0
        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Sleep")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.systemMint]
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
   
    /*
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

        lblUpdateDate.text = "\(formattedStartDate) - \(formattedEndDate)"
   
    }
    */
   
    //MARK: HalfYearly Data
    func updateBarChart3() {
        var count = 0
        var dataEntries: [ChartDataEntry] = []
        for (index, dataPoint) in halfyearlySleepData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: dataPoint.1)
            halfYearlyData = halfYearlyData + Int(dataPoint.1)
            print(dataPoint.1)
            count = index + index
            dataEntries.append(entry)
        }
        if count == 0 {
            self.lblData.text = "\(String(self.halfYearlyData)) min"
            halfYearlyData = 0
        } else {
            self.lblData.text = "\(String(self.halfYearlyData)) min"
            halfYearlyData = 0
        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Sleep")
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor.systemMint]
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
    
    /*
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

        lblUpdateDate.text = "\(formattedStartDate) - \(formattedEndDate)"
        
        
    }
    */
    
}









    
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUi()
        lblUpdateDate.text = "18 Jan 2024"
        fetchData1()
         
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func segmentBar(_ sender: UISegmentedControl) {
        switch segmentBar.selectedSegmentIndex {
        case 0:
            lblUpdateDate.text = "18 Jan 2024"
            fetchData1()
        case 1:
            lblUpdateDate.text = "14 - 20 Jan 2024"
            fetchData2()
        case 2:
            lblUpdateDate.text = "Jan 2024"
            fetchData3()
        case 3:
            lblUpdateDate.text = "31 Dec 2023 - 29 Jun 2024"
            fetchData4()
        default:
            break
        }
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

        let dataSet = LineChartDataSet(entries: dataEntries, label: "Hearing")
        dataSet.colors = [UIColor.systemPink]
        dataSet.circleColors = [UIColor.systemYellow]
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

        let dataSet = LineChartDataSet(entries: dataEntries, label: "Hearing")
        dataSet.colors = [UIColor.systemPink]
        dataSet.circleColors = [UIColor.systemYellow]
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

        let dataSet = LineChartDataSet(entries: dataEntries, label: "Hearing")
        dataSet.colors = [UIColor.systemPink]
        dataSet.circleColors = [UIColor.systemYellow]
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

        let dataSet = LineChartDataSet(entries: dataEntries, label: "Hearing")
        dataSet.colors = [UIColor.systemPink]
        dataSet.circleColors = [UIColor.systemYellow]
        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelTextColor = .black
        lineChartView.leftAxis.labelTextColor = .black
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = true
        
    }
   
    func setUpUi(){
        cellView.layer.cornerRadius = 10
        cellView.clipsToBounds = true
        chartView.layer.borderColor = UIColor.systemPink.cgColor
        chartView.layer.borderWidth = 0.2
        lineChartView = LineChartView()
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.addSubview(lineChartView)

        // Set up constraints
        NSLayoutConstraint.activate([
            lineChartView.topAnchor.constraint(equalTo: chartView.topAnchor, constant: 10),
            lineChartView.leadingAnchor.constraint(equalTo: chartView.leadingAnchor, constant: 20),
            lineChartView.trailingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: -20),
            lineChartView.bottomAnchor.constraint(equalTo: chartView.bottomAnchor, constant: -10)
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
    */
