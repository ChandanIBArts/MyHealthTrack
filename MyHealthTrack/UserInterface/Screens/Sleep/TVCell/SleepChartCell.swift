//
//  SleepChartCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 15/03/24.
//

import UIKit
import DGCharts

class SleepChartCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var lblUpdateDate: UILabel!
    @IBOutlet weak var btnTapQuestion: UIButton!
    @IBOutlet weak var chartView: UIView!
    
    var lineChartView = LineChartView()
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUi()
        lblUpdateDate.text = "18 Jan 2024"
        fetchData1()
        // Initialization code
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
    
}
