//
//  HearingBarchatTVCell.swift
//  MyHealthTrack
//
//  Created by IB Arts Mac on 14/03/24.
//

import UIKit
import DGCharts

class HearingBarchatTVCell: UITableViewCell {
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var segmentBar: UISegmentedControl!
    var lineChartView = LineChartView()

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUi()
        fetchData()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func segmentBar(_ sender: UISegmentedControl) {
        switch segmentBar.selectedSegmentIndex {
        case 0:
            fetchData()
        case 1:
            fetchData1()
        case 2:
            fetchData2()
        case 3:
            fetchData3()
        case 4:
            fetchData4()
        case 5:
            fetchData5()
            
        default:
            break
        }
    }
    
    
    func fetchData(){
        // Dummy data
        let dataEntries: [ChartDataEntry] = [
            ChartDataEntry(x: 0.0, y: 20.0),
            ChartDataEntry(x: 1.0, y: 25.0),
            ChartDataEntry(x: 2.0, y: 18.0),
            ChartDataEntry(x: 3.0, y: 30.0),
            ChartDataEntry(x: 4.0, y: 22.0)
        ]

        let dataSet = LineChartDataSet(entries: dataEntries, label: "Hearing")
        dataSet.colors = [UIColor.systemPink]

        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelTextColor = .black
        lineChartView.leftAxis.labelTextColor = .black
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = true
        
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

        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelTextColor = .black
        lineChartView.leftAxis.labelTextColor = .black
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = true
        
    }
    
    func fetchData5(){
        // Dummy data
        let dataEntries: [ChartDataEntry] = [
            ChartDataEntry(x: 0.0, y: 10.0),
            ChartDataEntry(x: 1.0, y: 5.0),
            ChartDataEntry(x: 2.0, y: 18.0),
            ChartDataEntry(x: 3.0, y: 30.0),
            ChartDataEntry(x: 4.0, y: 20.0),
            ChartDataEntry(x: 5.0, y: 18.0),
            ChartDataEntry(x: 6.0, y: 10.0),
            ChartDataEntry(x: 7.0, y: 25.0),
            ChartDataEntry(x: 8.0, y: 18.0),
            ChartDataEntry(x: 9.0, y: 30.0),
            ChartDataEntry(x: 10.0, y: 22.0),
            ChartDataEntry(x: 11.0, y: 15.0)
        ]

        let dataSet = LineChartDataSet(entries: dataEntries, label: "Hearing")
        dataSet.colors = [UIColor.systemPink]

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
        
        lineChartView = LineChartView()
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        cellView.addSubview(lineChartView)

        // Set up constraints
        NSLayoutConstraint.activate([
            lineChartView.topAnchor.constraint(equalTo: segmentBar.bottomAnchor, constant: 10),
            lineChartView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
            lineChartView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20),
            lineChartView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10)
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
