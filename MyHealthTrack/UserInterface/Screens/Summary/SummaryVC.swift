
import UIKit
import HealthKit


struct DataModel{
    
    var stepCounts: String!
    var distances: String!
    var activeEnergies: String!
    var restingEnergies: String!
    var heart: String!
    var height: String!
    var weight: String!
    var doubleSupport: String!
    var walkingSpeed: String!
    var walkingAsmmetry: String!
    var walkingStepLength: String!
    
    init(stepCounts: String!, distances: String!, activeEnergies: String!, restingEnergies: String!, heart: String!, height: String!, weight: String!, doubleSupport: String!, walkingSpeed: String!, walkingAsmmetry: String!, walkingStepLength: String!) {
        self.stepCounts = stepCounts
        self.distances = distances
        self.activeEnergies = activeEnergies
        self.restingEnergies = restingEnergies
        self.heart = heart
        self.height = height
        self.weight = weight
        self.doubleSupport = doubleSupport
        self.walkingSpeed = walkingSpeed
        self.walkingAsmmetry = walkingAsmmetry
        self.walkingStepLength = walkingStepLength
    }
}

struct ImgDataModel {
    
    var stepCounts: UIImage!
    var distances: UIImage!
    var activeEnergies: UIImage!
    var restingEnergies: UIImage!
    var heart: UIImage!
    var height: UIImage!
    var weight: UIImage!
    var doubleSupport: UIImage!
    var walkingSpeed: UIImage!
    var walkingAsmmetry: UIImage!
    var walkingStepLength: UIImage!
    
    init(stepCounts: UIImage!, distances: UIImage!, activeEnergies: UIImage!, restingEnergies: UIImage!, heart: UIImage!, height: UIImage!, weight: UIImage!, doubleSupport: UIImage!, walkingSpeed: UIImage!, walkingAsmmetry: UIImage!, walkingStepLength: UIImage!) {
        self.stepCounts = stepCounts
        self.distances = distances
        self.activeEnergies = activeEnergies
        self.restingEnergies = restingEnergies
        self.heart = heart
        self.height = height
        self.weight = weight
        self.doubleSupport = doubleSupport
        self.walkingSpeed = walkingSpeed
        self.walkingAsmmetry = walkingAsmmetry
        self.walkingStepLength = walkingStepLength
    }
    
    
    static var imageData : [ImgDataModel] = [
    
        ImgDataModel(stepCounts: UIImage(named: "Steps"), distances: UIImage(named: "Mobility"), activeEnergies: UIImage(named: "vitals"), restingEnergies: UIImage(named: "sleep"), heart: UIImage(named: "heart"), height: UIImage(named: "body-measurement"), weight: UIImage(named: "body-measurement"), doubleSupport: UIImage(named: "Mobility"), walkingSpeed: UIImage(named: "Activity"), walkingAsmmetry: UIImage(named: "symptoms"), walkingStepLength: UIImage(named: "mental"))
        
    
    ]
    
}

class SummaryVC: BaseViewController {

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var topShadowContainerView: UIView!
    @IBOutlet private weak var lblCaloriesValue: UILabel!
    @IBOutlet private weak var lblExerciseValue: UILabel!
    @IBOutlet private weak var lblStandValue: UILabel!
    @IBOutlet private weak var btnEdit: UIButton!
    @IBOutlet private weak var tblViewSummary: UITableView!
    
    
    private var viewModel = SummaryVM()
    let healthStore = HKHealthStore()
    
    var stepCounts: String!
    var distances: String!
    var activeEnergies: String!
    var restingEnergies: String!
    var heart: String!
    var height: String!
    var weight: String!
    var doubleSupport: String!
    var walkingSpeed: String!
    var walkingAsmmetry: String!
    var walkingStepLength: String!
    
    var helthKitDataModel = [DataModel]()
    var imgArr = ImgDataModel.imageData
    var titleArr = ["Step","Running & Walking Distance","Active Energies","Resting Energies","Heart Rate","Height","Weight","Double Support","Walking Speed","Walking Asmmetry","Walking StepLength"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHelkitData()
        setupGredient()
        setupInitialUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // fetchDataAndUpload()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactivePopSetup(enable: false)
        
        HealthKitManager.default.requestAuthorization {[weak self ] success in
            guard let self = self, success else { return }
            self.viewModel.fetchSumaryData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.height/2
    }
    
    
    override func bindViewModel() {
        viewModel.willFetchData = {
            runOnMainThread {
                AppLoader.shared.loader(true)
            }
        }
        
        viewModel.dataFetched = {[weak self] in
            guard let self = self else { return }
            AppLoader.shared.loader(false)
            self.setupDataOnUI()
        }
    }
    
    @IBAction private func editProfileTap(_ sender: UIButton) {
        CoordinatorManager.shared.mainCoordinator?.gotoEditProfile()
    }
    
    @IBAction func syncAction(_ sender: Any) {
        uploadData()
    }
    
}

//MARK: - Tableview Delegate and Datasources implementation -

extension SummaryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTVCell", for: indexPath) as! SummaryTVCell
    
        cell.titleText.text = titleArr[indexPath.row]
            
        if indexPath.row == 0 {
            cell.imgView.image = imgArr[0].stepCounts
            cell.cellData.text = helthKitDataModel[0].stepCounts
            cell.titleText.textColor = UIColor(red: 127.0/255.0, green: 226.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        } else if indexPath.row == 1 {
            cell.imgView.image = imgArr[0].distances
            cell.cellData.text = helthKitDataModel[0].distances
            cell.titleText.textColor = UIColor(red: 108.0/255.0, green: 195.0/255.0, blue: 138.0/255.0, alpha: 1.0)
        } else if indexPath.row == 2 {
            cell.imgView.image = imgArr[0].activeEnergies
            cell.cellData.text = helthKitDataModel[0].activeEnergies
            cell.titleText.textColor = UIColor(red: 130.0/255.0, green: 177.0/255.0, blue: 72.0/255.0, alpha: 1.0)
        } else if indexPath.row == 3 {
            cell.imgView.image = imgArr[0].restingEnergies
            cell.cellData.text = helthKitDataModel[0].restingEnergies
            cell.titleText.textColor = UIColor(red: 245.0/255.0, green: 204.0/255.0, blue: 96.0/255.0, alpha: 1.0)
        } else if indexPath.row == 4 {
            cell.imgView.image = imgArr[0].heart
            cell.cellData.text = helthKitDataModel[0].heart
            cell.titleText.textColor = UIColor(red: 324.0/255.0, green: 51.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        } else if indexPath.row == 5 {
            cell.imgView.image = imgArr[0].height
            cell.cellData.text = helthKitDataModel[0].height
            cell.titleText.textColor = UIColor(red: 171.0/255.0, green: 204.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        } else if indexPath.row == 6 {
            cell.imgView.image = imgArr[0].weight
            cell.cellData.text = helthKitDataModel[0].weight
            cell.titleText.textColor = UIColor(red: 171.0/255.0, green: 204.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        } else if indexPath.row == 7 {
            cell.imgView.image = imgArr[0].doubleSupport
            cell.cellData.text = helthKitDataModel[0].doubleSupport
            cell.titleText.textColor = UIColor(red: 108.0/255.0, green: 197.0/255.0, blue: 138.0/255.0, alpha: 1.0)
        } else if indexPath.row == 8 {
            cell.imgView.image = imgArr[0].walkingSpeed
            cell.cellData.text = helthKitDataModel[0].walkingSpeed
            cell.titleText.textColor = UIColor(red: 95.0/255.0, green: 194.0/255.0, blue: 184.0/255.0, alpha: 1.0)
        } else if indexPath.row == 9 {
            cell.imgView.image = imgArr[0].walkingAsmmetry
            cell.cellData.text = helthKitDataModel[0].walkingAsmmetry
            cell.titleText.textColor = UIColor(red: 113.0/255.0, green: 227.0/255.0, blue: 216.0/255.0, alpha: 1.0)
        } else {
            cell.imgView.image = imgArr[0].walkingStepLength
            cell.cellData.text = helthKitDataModel[0].walkingStepLength
            cell.titleText.textColor = UIColor(red: 171.0/255.0, green: 204.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let currentTime = Date()
        let formattedTime = dateFormatter.string(from: currentTime)
        cell.time.text = formattedTime
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Details_StepsVC") as! Details_StepsVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Details_Walking_RunningDistanceVC") as! Details_Walking_RunningDistanceVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Details_ActiveEnrgyVC") as! Details_ActiveEnrgyVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Details_RestingEnergyVC") as! Details_RestingEnergyVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsHartRateVC") as! DetailsHartRateVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 5 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsHeightVC") as! DetailsHeightVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 6 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsWeightVC") as! DetailsWeightVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 7 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsDoubleSupportVC") as! DetailsDoubleSupportVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 8 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsWalkingSpeedVC") as! DetailsWalkingSpeedVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 9 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsWalkingAsymmetryVC") as! DetailsWalkingAsymmetryVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsWalkingStepLengthVC") as! DetailsWalkingStepLengthVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let _ = self.viewModel.summaryData else { return 0}
        return SummaryItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SummaryHealthDataCell.viewIdentifier) as? SummaryHealthDataCell else { fatalError("Unable to load the cell") }
        
        guard let item = SummaryItem(rawValue: indexPath.row) else { fatalError("case need to be handle") }
        let summaryData = self.viewModel.summaryData
        var value: Int
        var timeString: String?
        
        switch item {
        case .step:
            value = summaryData?.stepCount?.value ?? 0
            timeString = summaryData?.stepCount?.timeString
        case .heartRate:
            value = summaryData?.heartRate?.value ?? 0
            timeString = summaryData?.heartRate?.timeString
        case .restingHeartRate:
            value =  summaryData?.heartRateResting?.value ?? 0
            timeString = summaryData?.heartRateResting?.timeString
        case .workout:
            value = summaryData?.exerciseDuration?.value ?? 0
            timeString = summaryData?.exerciseDuration?.timeString
        case .walkingHeartRate:
            value = summaryData?.walkingHeartRate?.value ?? 0
            timeString = summaryData?.walkingHeartRate?.timeString
        case .heartRateVariability:
            value = summaryData?.heartRateVariablity?.value ?? 0
            timeString = summaryData?.heartRateVariablity?.timeString
        }
        
        cell.setupCell(item: item, value: "\(value)", time: timeString)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
     */
}

// MARK: - UI related setup
extension SummaryVC {
    
    private func setupInitialUI() {
//        
        tblViewSummary.delegate = self
        tblViewSummary.dataSource = self
        tblViewSummary.register(UINib(nibName: "SummaryTVCell", bundle: nil), forCellReuseIdentifier: "SummaryTVCell")

        tblViewSummary.estimatedRowHeight = 92
        tblViewSummary.rowHeight = UITableView.automaticDimension

        setupDataOnUI()
    }
    
    private func setupDataOnUI() {
        setupAttributedTexts(
            calories: viewModel.summaryData?.caloriesBurn?.value ?? 0,
            exercise: viewModel.summaryData?.exerciseDuration?.value ?? 0,
            stand: viewModel.summaryData?.standDuration?.value ?? 0)
        self.tblViewSummary.reloadData()
    }
    
    private func setupAttributedTexts(calories: Int, exercise: Int, stand: Int) {
        lblCaloriesValue.attributedText = setupAttributed(value: "\(calories)", unit: "Cal")
        lblExerciseValue.attributedText = setupAttributed(value: "\(exercise)", unit: "min")
        lblStandValue.attributedText = setupAttributed(value: "\(stand)", unit: "hrs")
    }
    
    private func setupAttributed(value: String, unit: String) -> NSAttributedString {
        let fullString = value + " " + unit
        let subString = unit
        let range = (fullString as NSString).range(of: subString)
        
        let fullStringColor: UIColor = .black
        let subStringColor: UIColor = .projectDarkGray
        
        let fullStringFont = UIFont.systemFont(ofSize: 20, weight: .heavy)
        let subStringFont = UIFont.systemFont(ofSize: 15, weight: .regular)

        let attributedString = NSMutableAttributedString(string:fullString)
        
        // Setup full string color and font
        attributedString.addAttribute(.foregroundColor,
                                      value: fullStringColor,
                                      range: NSRange(location: 0, length: fullString.count))
        attributedString.addAttribute(.font,
                                      value: fullStringFont,
                                      range: NSRange(location: 0, length: fullString.count))

        // Setup Sub string color and font
        attributedString.addAttribute(.foregroundColor,
                                      value: subStringColor,
                                      range: range)
        attributedString.addAttribute(.font,
                                      value: subStringFont,
                                      range: range)
        return attributedString
    }
    
    private func setupGredient() {
        let colors: [UIColor] = [
            .projectGreen,
            .projectGreen.withAlphaComponent(0.5),
            .projectSummaryBG
        ]
        view.addGradient(colors, locations: [0.0, 0.20, 0.33],frame: view.bounds)
    }
}

extension SummaryVC {
    
    func uploadData(){
        guard let url = URL(string: "http://mht.demospace.cloud/api/process-data") else {
            print("Invalid URL")
            return
        }

        let json: [String: Any] = [
            "Activity": [
                "Steps": stepCounts,
                "Walking Running Distance": distances,
                "Active Energy": activeEnergies,
                "Resting Energy": restingEnergies
            ],
            "Heart Rate": heart,
            "Body Measurements": [
                "Height": height,
                "Weight": weight
            ],
            "Mobility": [
                "Double Support Time": doubleSupport,
                "Walking Speed": walkingSpeed,
                "Walking Asmmetry": walkingAsmmetry,
                "Walking Step Length": walkingStepLength
            ],
            
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                if let responseString = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        print("Response: \(responseString)")
                        let alert = UIAlertController(title: "MyHealthTrack", message: "Data synchronization successful" , preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Done", style: .default))
                        self.present(alert, animated: true)
                    }
                }
            }
            task.resume()
        } catch {
            print("Error serializing JSON: \(error)")
        }

    }
    
    
   
    
    func fetchHelkitData(){
        
        
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let activeEnergyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let restingEnergyType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let heightType = HKQuantityType.quantityType(forIdentifier: .height)!
        let weightType = HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        let doubleSupportType = HKQuantityType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!
        let walkingSpeedType = HKQuantityType.quantityType(forIdentifier: .walkingSpeed)!
        let walkingAsymmetryType = HKQuantityType.quantityType(forIdentifier: .walkingAsymmetryPercentage)!
        let walkingStepLengthType = HKQuantityType.quantityType(forIdentifier: .walkingStepLength)!

        // Define the date range for your query (Today)
        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Date()

        // Create a predicate to query the data for today
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        // Create a query for step count
        let stepCountQuery = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            guard let result = result, let sum = result.sumQuantity() else {
                if let error = error {
                    print("Failed to fetch step count data: \(error.localizedDescription)")
                }
                return
            }
            let stepCount = sum.doubleValue(for: HKUnit.count())
            print("Step count today: \(stepCount)")
            let count = String(format: "%.0f", stepCount)
            self.stepCounts = "\(count) Steps"
        }

        // Create a query for distance (walking + running)
        let distanceQuery = HKStatisticsQuery(quantityType: distanceType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            guard let result = result, let sum = result.sumQuantity() else {
                if let error = error {
                    print("Failed to fetch distance data: \(error.localizedDescription)")
                }
                return
            }
            let distance = sum.doubleValue(for: HKUnit.meter())
            print("Distance today: \(distance) meters")
            let rwDistance = String(format: "%.0f", distance/1000)
            self.distances = "\(rwDistance) Km"
        }

        // Create a query for active energy
        let activeEnergyQuery = HKStatisticsQuery(quantityType: activeEnergyType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            guard let result = result, let sum = result.sumQuantity() else {
                if let error = error {
                    print("Failed to fetch active energy data: \(error.localizedDescription)")
                }
                return
            }
            let activeEnergy = sum.doubleValue(for: HKUnit.kilocalorie())
            print("Active energy today: \(activeEnergy) kcal")
            let activeE = String(format: "%.0f", activeEnergy)
            self.activeEnergies = "\(activeE) Kcal"
        }

        // Create a query for resting energy
        let restingEnergyQuery = HKStatisticsQuery(quantityType: restingEnergyType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            guard let result = result, let sum = result.sumQuantity() else {
                if let error = error {
                    print("Failed to fetch resting energy data: \(error.localizedDescription)")
                }
                return
            }
            let restingEnergy = sum.doubleValue(for: HKUnit.kilocalorie())
            print("Resting energy today: \(restingEnergy) kcal")
            let restingE = String(format: "%.0f", restingEnergy)
            self.restingEnergies = "\(restingE) Kcal"
           
        }
        
        // Create a query for heart rate
        let heartRateQuery = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { (_, result, error) in
            guard let result = result, let average = result.averageQuantity() else {
                if let error = error {
                    print("Failed to fetch heart rate data: \(error.localizedDescription)")
                }
                return
            }
            let heartRate = average.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
            print("Average heart rate today: \(heartRate) bpm")
            let heart = String(format: "%.0f", heartRate)
            self.heart = "\(heart) bpm"
        }

        // Create a query for height
        let heightQuery = HKStatisticsQuery(quantityType: heightType, quantitySamplePredicate: predicate, options: .discreteAverage) { (_, result, error) in
            guard let result = result, let average = result.averageQuantity() else {
                if let error = error {
                    print("Failed to fetch height data: \(error.localizedDescription)")
                }
                return
            }
            let height = average.doubleValue(for: HKUnit.meter())
            print("Average height today: \(height) meters")
            let heights = String(format: "%.0f", height * 100)
            self.height = "\(heights) Centimeter"
        }

        // Create a query for weight
        let weightQuery = HKStatisticsQuery(quantityType: weightType, quantitySamplePredicate: predicate, options: .discreteAverage) { (_, result, error) in
            guard let result = result, let average = result.averageQuantity() else {
                if let error = error {
                    print("Failed to fetch weight data: \(error.localizedDescription)")
                }
                return
            }
            let weight = average.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            print("Average weight today: \(weight) kg")
            let weights = String(format: "%.0f", weight)
            self.weight = "\(weights) Kg"
        }
       
        
        // Create a query for double support
        let doubleSupportQuery = HKStatisticsQuery(quantityType: doubleSupportType, quantitySamplePredicate: predicate, options: .discreteAverage) { (_, result, error) in
            guard let result = result, let average = result.averageQuantity() else {
                if let error = error {
                    print("Failed to fetch double support data: \(error.localizedDescription)")
                }
                return
            }
            let doubleSupport = average.doubleValue(for: HKUnit.percent())
            print("Average double support today: \(doubleSupport)%")
            let dpSupport = String(format: "%.2f", doubleSupport)
            self.doubleSupport = "\(dpSupport) %"
        }

        // Create a query for walking speed
        let walkingSpeedQuery = HKStatisticsQuery(quantityType: walkingSpeedType, quantitySamplePredicate: predicate, options: .discreteAverage) { (_, result, error) in
            guard let result = result, let average = result.averageQuantity() else {
                if let error = error {
                    print("Failed to fetch walking speed data: \(error.localizedDescription)")
                }
                return
            }
            let walkingSpeed = average.doubleValue(for: HKUnit.meter().unitDivided(by: .hour()))
            print("Average walking speed today: \(walkingSpeed) m/h")
            let wSpeed = String(format: "%.0f", walkingSpeed)
            self.walkingSpeed = "\(wSpeed) m/h"
        }
        
        // Create a query for walking asymmetry
        let walkingAsymmetryQuery = HKStatisticsQuery(quantityType: walkingAsymmetryType, quantitySamplePredicate: predicate, options: .discreteAverage) { (_, result, error) in
            guard let result = result, let average = result.averageQuantity() else {
                if let error = error {
                    print("Failed to fetch walking asymmetry data: \(error.localizedDescription)")
                }
                return
            }
            let walkingAsymmetry = average.doubleValue(for: HKUnit.percent())
            print("Walking asymmetry today: \(walkingAsymmetry)%")
            let wAsymmetry = String(format: "%.2f", walkingAsymmetry)
            self.walkingAsmmetry = "\(wAsymmetry) %"
        }

        // Create a query for walking step length
        let walkingStepLengthQuery = HKStatisticsQuery(quantityType: walkingStepLengthType, quantitySamplePredicate: predicate, options: .discreteAverage) { (_, result, error) in
            guard let result = result, let average = result.averageQuantity() else {
                if let error = error {
                    print("Failed to fetch walking step length data: \(error.localizedDescription)")
                }
                return
            }
            let walkingStepLength = average.doubleValue(for: HKUnit.meter())
            print("Walking step length today: \(walkingStepLength) meters")
            let wStepLength = String(format: "%.0f", walkingStepLength * 100)
            self.walkingStepLength = "\(wStepLength) Centimeter"
            
    
            self.helthKitDataModel.append(DataModel(
                stepCounts: self.stepCounts as? String ?? "0 Steps",
                distances: self.distances as? String ?? "0 Km",
                activeEnergies: self.activeEnergies as? String ?? "0 Kcal",
                restingEnergies: self.restingEnergies as? String ?? "0 Kcal",
                heart: self.heart as? String ?? "0 bpm",
                height: self.height as? String ?? "0 Centimeter",
                weight: self.weight as? String ?? "0 Kg",
                doubleSupport: self.doubleSupport as? String ?? "0 %",
                walkingSpeed: self.walkingSpeed as? String ?? "0 m/h",
                walkingAsmmetry: self.walkingAsmmetry as? String ?? "0 %",
                walkingStepLength: self.walkingStepLength as? String ?? "0 Centimeter"))
            DispatchQueue.main.async {
                self.tblViewSummary.reloadData()
            }
                
        }
        

        // Execute the queries
        healthStore.execute(stepCountQuery)
        healthStore.execute(distanceQuery)
        healthStore.execute(activeEnergyQuery)
        healthStore.execute(restingEnergyQuery)
        healthStore.execute(heartRateQuery)
        healthStore.execute(heightQuery)
        healthStore.execute(weightQuery)
        healthStore.execute(doubleSupportQuery)
        healthStore.execute(walkingSpeedQuery)
        healthStore.execute(walkingAsymmetryQuery)
        healthStore.execute(walkingStepLengthQuery)
        
    }
    
}
