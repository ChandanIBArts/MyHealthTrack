//
//  AnexietyRiskVC.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 20/02/24.
//

import UIKit
import Charts
import DGCharts
import HealthKit

class AnexietyRiskVC: UIViewController {
    
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var dailyTotalCount = 0
    var weeklyTotalCount = 0
    var monthlyTotalCount = 0
    var halfYearlyTotalCount = 0
    var yearlyTotalCount = 0
    
    let healthKitManager = DetailsAnexietyRiskHealthKitManager()
    var barChartView = BarChartView()
    var staticData = StaticModel.AnxietyModel
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        barChartView.frame = CGRect(x: 0, y: 0, width: Int(view.frame.size.width), height: Int(view.frame.size.width))
        barChartView.center = view.center
        chartsManage()
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
            //MARK: Daily Hrs Data
            lblTotal.text = "TOTAL"
            lblDay.text = "Today"
            healthKitManager.requestDailyAuthorization { success, _ in
                if success {
                    self.healthKitManager.fetchDailyStepCount { stepCountData in
                        self.updateBarChart(with: stepCountData)
                        self.barChartView.xAxis.labelPosition = .bottom
                        DispatchQueue.main.async {
                            self.lblData.text = "80"//"\(HealthKitmanager.dailySteps!) Steps"
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
                    self.healthKitManager.fetchWeeklyStepCount { stepCountData in
                        self.updateBarChart1(with: stepCountData)
                        self.barChartView.xAxis.labelPosition = .bottom
                        DispatchQueue.main.async {
                            self.lblData.text = "80"//"\(String(self.weeklyTotalCount/7)) Steps"
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
                    self.healthKitManager.fetchMonthlyStepCount { stepCountData in
                        self.updateBarChart2(with: stepCountData)
                        self.barChartView.xAxis.labelPosition = .bottom
                        DispatchQueue.main.async {
                            self.lblData.text = "80"//"\(String(self.monthlyTotalCount/30)) Steps"
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
                    self.healthKitManager.fetchHalfYearlyStepCount { stepCountData in
                        self.updateBarChart3(with: stepCountData)
                        self.barChartView.xAxis.labelPosition = .bottom
                        DispatchQueue.main.async {
                            self.lblData.text = "80"//"\(String(self.halfYearlyTotalCount/180)) Steps"
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
                    self.healthKitManager.fetchYearlyStepCount { stepCountData in
                        self.updateBarChart4(with: stepCountData)
                        self.barChartView.xAxis.labelPosition = .bottom
                        DispatchQueue.main.async {
                            self.lblData.text = "80"//"\(String(self.yearlyTotalCount/365)) Steps"
                            self.yearlyTotalCount = 0
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
             self.view.addSubview(barChart)
             barChart.center = self.view.center
             
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
             self.view.addSubview(barChart)
             barChart.center = self.view.center
             
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
             self.view.addSubview(barChart)
             barChart.center = self.view.center
             
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
             self.view.addSubview(barChart)
             barChart.center = self.view.center
             
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
             self.view.addSubview(barChart)
             barChart.center = self.view.center
             
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

extension AnexietyRiskVC {
    
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

extension AnexietyRiskVC: UITableViewDataSource, UITableViewDelegate {
    
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "Static_Anexiety_TextCell", for: indexPath) as! Static_Anexiety_TextCell
            cell.lblTitle.text = "About Anxiety Risk"
            cell.lblDescrip.text = "Anxiety risk refers to an individual's risk of anxiety-related mental health conditions. This reflects the risk at the time of the most recent mental health assessment score based on the Generalised Anxiety Disorder. \n \nQuestionnaire-7 (GAD-7). The GAD-7 is a tool doctors use to help screen for and measure someone's anxiety symptoms over a two-week period. A mental health questionnaire can be an important part of learning about what's impacting your mental health. Depending on your family history, biology or current life events, your anxiety risk may go up or down. \n \nAnxiety is a common and treatable condition. Your anxiety risk is not a diagnosis of any health condition. If you have any questions about your mental health, you should bring them up with a doctor. You can learn more about your current risk of anxiety by taking a mental health questionnaire in Health."
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Static_Anexiety_ImgCell", for: indexPath) as! Static_Anexiety_ImgCell
            cell.imgView.image = staticData[indexPath.row].img
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
             
            return 480
            
        } else {
            
            return 250
            
        }
    }
    
    
}
