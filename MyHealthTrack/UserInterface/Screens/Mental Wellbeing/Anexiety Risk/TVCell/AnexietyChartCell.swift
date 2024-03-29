//
//  AnexietyChartCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 15/03/24.
//

import UIKit
import DGCharts
import HealthKit

class AnexietyChartCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var chartView: UIView!
    
    var dailyTotalCount = 0
    var weeklyTotalCount = 0
    var monthlyTotalCount = 0
    var halfYearlyTotalCount = 0
    var yearlyTotalCount = 0
    
    let healthTrackManager = DetailsAnexietyRiskHealthKitManager()
    
    var barChartView = BarChartView()

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUi()
        healthTrackManager.requestAuthorization { [self] (success, error) in
            if success {
                healthTrackManager.fetchAppleStandHourData(for: .daily) { (data, error) in
                    if let data = data {
                        DispatchQueue.main.async { [self] in
                            print("Anxiety Risk data: \(data)")
                            let chartData = data
                            self.lastDay()
                            if data.count != 0 {
                                for (index, data) in data.enumerated() {
                                    let entry = BarChartDataEntry(x: Double(index), y: data.1)
                                    self.dailyTotalCount = self.dailyTotalCount + Int(data.1)
                                    self.lblData.text = "\(String(format: "%.0f",self.dailyTotalCount)) bpm"
                                    self.updateBarChart(with: chartData)
                                }
                            } else {
                                self.lblData.text = "No data found"
                                self.barChartView.data = []
                            }
                        }
                    } else if let error = error {
                        print("Error fetching Anxiety Risk data: \(error.localizedDescription)")
                    }
                        
                }
            }
        }
       
        /*
        //MARK: Daily Hrs Data
        healthKitManager.requestDailyAuthorization { success, _ in
            if success {
                self.healthKitManager.fetchDailyStepCount { stepCountData in
                    self.updateBarChart(with: stepCountData)
                    self.barChartView.xAxis.labelPosition = .bottom
                    DispatchQueue.main.async {
                        self.lblData.text = "80" //"\(HealthKitmanager.dailySteps!) Steps"
                        self.dailyTotalCount = 0
                    }
                }
            }
        }
         */
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func segmentBar(_ sender: UISegmentedControl) {
 
        switch segmentBar.selectedSegmentIndex {
            
        case 0:
            
            healthTrackManager.requestAuthorization { [self] (success, error) in
                if success {
                    healthTrackManager.fetchAppleStandHourData(for: .daily) { (data, error) in
                        if let data = data {
                            DispatchQueue.main.async {
                                print("Anxiety Risk data: \(data)")
                                let chartData = data
                                self.lastDay()
                                if data.count != 0 {
                                    for (index, data) in data.enumerated() {
                                        let entry = BarChartDataEntry(x: Double(index), y: data.1)
                                        self.dailyTotalCount = self.dailyTotalCount + Int(data.1)
                                        self.lblData.text = "\(String(format: "%.0f",self.dailyTotalCount)) bpm"
                                        self.updateBarChart(with: chartData)
                                    }
                                } else {
                                    self.lblData.text = "No data found"
                                    self.barChartView.data = []
                                }
                            }
                        } else if let error = error {
                            print("Error fetching Anxiety Risk data: \(error.localizedDescription)")
                        }
                    }
                }
            }
        case 1:
            healthTrackManager.requestAuthorization { [self] (success, error) in
                if success {
                    healthTrackManager.fetchAppleStandHourData(for: .weekly) { (data, error) in
                        if let data = data {
                            DispatchQueue.main.async {
                                print("Anxiety Risk data: \(data)")
                                let chartData = data
                                self.lastWeek()
                                if data.count != 0 {
                                    for (index, data) in data.enumerated() {
                                        let entry = BarChartDataEntry(x: Double(index), y: data.1)
                                        self.dailyTotalCount = self.dailyTotalCount + Int(data.1)
                                        self.lblData.text = "\(String(format: "%.0f",self.dailyTotalCount)) bpm"
                                        self.updateBarChart1(with: chartData)
                                    }
                                } else {
                                    self.lblData.text = "No data found"
                                    self.barChartView.data = []
                                }
                            }
                        } else if let error = error {
                            print("Error fetching Anxiety Risk data: \(error.localizedDescription)")
                        }
                    }
                }
            }
            
        case 2:
            healthTrackManager.requestAuthorization { [self] (success, error) in
                if success {
                    healthTrackManager.fetchAppleStandHourData(for: .monthly) { (data, error) in
                        if let data = data {
                            DispatchQueue.main.async {
                                print("Anxiety Risk data: \(data)")
                                let chartData = data
                                self.lastMonth()
                                if data.count != 0 {
                                    for (index, data) in data.enumerated() {
                                        let entry = BarChartDataEntry(x: Double(index), y: data.1)
                                        self.dailyTotalCount = self.dailyTotalCount + Int(data.1)
                                        self.lblData.text = "\(String(format: "%.0f",self.dailyTotalCount)) bpm"
                                        self.updateBarChart2(with: chartData)
                                    }
                                } else {
                                    self.lblData.text = "No data found"
                                    self.barChartView.data = []
                                }
                            }
                        } else if let error = error {
                            print("Error fetching Anxiety Risk data: \(error.localizedDescription)")
                        }
                    }
                }
            }
            
        case 3:
            healthTrackManager.requestAuthorization { [self] (success, error) in
                if success {
                    healthTrackManager.fetchAppleStandHourData(for: .halfYearly) { (data, error) in
                        if let data = data {
                            DispatchQueue.main.async {
                                print("Anxiety Risk data: \(data)")
                                let chartData = data
                                self.last6Month()
                                if data.count != 0 {
                                    for (index, data) in data.enumerated() {
                                        let entry = BarChartDataEntry(x: Double(index), y: data.1)
                                        self.dailyTotalCount = self.dailyTotalCount + Int(data.1)
                                        self.lblData.text = "\(String(format: "%.0f",self.dailyTotalCount)) bpm"
                                        self.updateBarChart3(with: chartData)
                                    }
                                } else {
                                    self.lblData.text = "No data found"
                                    self.barChartView.data = []
                                }
                            }
                        } else if let error = error {
                            print("Error fetching Anxiety Risk data: \(error.localizedDescription)")
                        }
                    }
                }
            }
            
        case 4:
            healthTrackManager.requestAuthorization { [self] (success, error) in
                if success {
                    healthTrackManager.fetchAppleStandHourData(for: .yearly) { (data, error) in
                        if let data = data {
                            DispatchQueue.main.async {
                                print("Anxiety Risk data: \(data)")
                                let chartData = data
                                self.lastYear()
                                if data.count != 0 {
                                    for (index, data) in data.enumerated() {
                                        let entry = BarChartDataEntry(x: Double(index), y: data.1)
                                        self.dailyTotalCount = self.dailyTotalCount + Int(data.1)
                                        self.lblData.text = "\(String(format: "%.0f",self.dailyTotalCount)) bpm"
                                        self.updateBarChart4(with: chartData)
                                    }
                                } else {
                                    self.lblData.text = "No data found"
                                    self.barChartView.data = []
                                }
                            }
                        } else if let error = error {
                            print("Error fetching Anxiety Risk data: \(error.localizedDescription)")
                        }
                    }
                }
            }
            
        default:
            break
        }
       
    }
    
    
    
     //MARK: Daily Hrs Data
     func updateBarChart(with stepCountData: [(Date, Double)]) {
         var entries: [BarChartDataEntry] = []
         for (index, data) in stepCountData.enumerated() {
             let entry = BarChartDataEntry(x: Double(index), y: data.1)
             dailyTotalCount = dailyTotalCount + Int(data.1)
             entries.append(entry)
         }
         let dataSet = BarChartDataSet(entries: entries, label: "Daily Step Count")
         let data = BarChartData(dataSet: dataSet)
         
         let color = UIColor(red: 151.0/255.0, green: 250.0/255.0, blue: 246.0/255.0, alpha: 1.0)
         let cgColor = color.cgColor
         let nsuicolor = NSUIColor(cgColor: cgColor)
         dataSet.colors = [nsuicolor]
         
         //dataSet.colors = [NSUIColor(cgColor: UIColor.red.cgColor)]
         dataSet.drawValuesEnabled = false
         let barChart = barChartView
         DispatchQueue.main.async {
             self.barChartView.data = data
             self.cellView.addSubview(barChart)
             barChart.center = self.cellView.center
             
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
     func updateBarChart1(with stepCountData: [(Date, Double)]) {
         var entries: [BarChartDataEntry] = []
         for (index, data) in stepCountData.enumerated() {
             let entry = BarChartDataEntry(x: Double(index), y: data.1)
             weeklyTotalCount = weeklyTotalCount + Int(data.1)
             entries.append(entry)
         }
         let dataSet = BarChartDataSet(entries: entries, label: "Weekly Step Count")
         let data = BarChartData(dataSet: dataSet)
         
         let color = UIColor(red: 151.0/255.0, green: 250.0/255.0, blue: 246.0/255.0, alpha: 1.0)
         let cgColor = color.cgColor
         let nsuicolor = NSUIColor(cgColor: cgColor)
         dataSet.colors = [nsuicolor]
         
         //dataSet.colors = [NSUIColor(cgColor: UIColor.red.cgColor)]
         dataSet.drawValuesEnabled = false
         let barChart = barChartView
         DispatchQueue.main.async {
             self.barChartView.data = data
             self.cellView.addSubview(barChart)
             barChart.center = self.cellView.center
             
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
     func updateBarChart2(with stepCountData: [(Date, Double)]) {
         var entries: [BarChartDataEntry] = []
         for (index, data) in stepCountData.enumerated() {
             let entry = BarChartDataEntry(x: Double(index), y: data.1)
             monthlyTotalCount = monthlyTotalCount + Int(data.1)
             entries.append(entry)
         }
         let dataSet = BarChartDataSet(entries: entries, label: "Monthly Step Count")
         let data = BarChartData(dataSet: dataSet)
         
         let color = UIColor(red: 151.0/255.0, green: 250.0/255.0, blue: 246.0/255.0, alpha: 1.0)
         let cgColor = color.cgColor
         let nsuicolor = NSUIColor(cgColor: cgColor)
         dataSet.colors = [nsuicolor]
         
         //dataSet.colors = [NSUIColor(cgColor: UIColor.red.cgColor)]
         dataSet.drawValuesEnabled = false
         let barChart = barChartView
         DispatchQueue.main.async {
             self.barChartView.data = data
             self.cellView.addSubview(barChart)
             barChart.center = self.cellView.center
             
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
     func updateBarChart3(with stepCountData: [(Date, Double)]) {
         var entries: [BarChartDataEntry] = []
         for (index, data) in stepCountData.enumerated() {
             let entry = BarChartDataEntry(x: Double(index), y: data.1)
             print(data.1)
             halfYearlyTotalCount = halfYearlyTotalCount + Int(data.1)
             entries.append(entry)
         }
         let dataSet = BarChartDataSet(entries: entries, label: "Half Yearly Step Count")
         let data = BarChartData(dataSet: dataSet)
         
         let color = UIColor(red: 151.0/255.0, green: 250.0/255.0, blue: 246.0/255.0, alpha: 1.0)
         let cgColor = color.cgColor
         let nsuicolor = NSUIColor(cgColor: cgColor)
         dataSet.colors = [nsuicolor]
         
         //dataSet.colors = [NSUIColor(cgColor: UIColor.red.cgColor)]
         dataSet.drawValuesEnabled = false
         let barChart = barChartView
         DispatchQueue.main.async {
             self.barChartView.data = data
             self.cellView.addSubview(barChart)
             barChart.center = self.cellView.center
             
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
     func updateBarChart4(with stepCountData: [(Date, Double)]) {
         var entries: [BarChartDataEntry] = []
         for (index, data) in stepCountData.enumerated() {
             let entry = BarChartDataEntry(x: Double(index), y: data.1)
             print(data.1)
             yearlyTotalCount = yearlyTotalCount + Int(data.1)
             entries.append(entry)
         }
         let dataSet = BarChartDataSet(entries: entries, label: "Yearly Step Count")
         let data = BarChartData(dataSet: dataSet)
         
         
         let color = UIColor(red: 151.0/255.0, green: 250.0/255.0, blue: 246.0/255.0, alpha: 1.0)
         let cgColor = color.cgColor
         let nsuicolor = NSUIColor(cgColor: cgColor)
         dataSet.colors = [nsuicolor]
         
         //dataSet.colors = [NSUIColor(cgColor: UIColor.red.cgColor)]
         dataSet.drawValuesEnabled = false
         let barChart = barChartView
         DispatchQueue.main.async {
             self.barChartView.data = data
             self.cellView.addSubview(barChart)
             barChart.center = self.cellView.center
             
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
 
    func setUpUi(){
        chartView.layer.borderWidth = 0.8
        chartView.layer.borderColor = UIColor.systemGreen.cgColor
        chartView.clipsToBounds = true
        chartView.layer.cornerRadius = 8
        cellView.layer.cornerRadius = 10
        cellView.clipsToBounds = true
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.addSubview(barChartView)
        // Set up constraints
        NSLayoutConstraint.activate([
            barChartView.topAnchor.constraint(equalTo: chartView.topAnchor, constant: 1),
            barChartView.leadingAnchor.constraint(equalTo: chartView.leadingAnchor, constant: 1),
            barChartView.trailingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: -1),
            barChartView.bottomAnchor.constraint(equalTo: chartView.bottomAnchor, constant: -1)
        ])
        
        chartsManage()
    }
    
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
    
    
    func lastDay(){
        func formatDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, dd MMM yyyy"
            let dateString = dateFormatter.string(from: Date())
            return dateString
        }
        lblDay.text = formatDate()
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
