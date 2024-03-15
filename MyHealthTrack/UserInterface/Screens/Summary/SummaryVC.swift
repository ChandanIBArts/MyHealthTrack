
import UIKit

class SummaryVC: BaseViewController {

    private var viewModel = SummaryVM()
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var topShadowContainerView: UIView!
    @IBOutlet private weak var lblCaloriesValue: UILabel!
    @IBOutlet private weak var lblExerciseValue: UILabel!
    @IBOutlet private weak var lblStandValue: UILabel!
    @IBOutlet private weak var btnEdit: UIButton!
    @IBOutlet private weak var tblViewSummary: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGredient()
        setupInitialUI()
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
        let summaryData = self.viewModel.summaryData

        //Call API sync
        let parameters = "{\n    \"Activity\" : {\n        \"Move\" :\"22\",\n        \"Steps\":\"\(summaryData?.stepCount?.value ?? 0)\",\n        \"Walking\":\"0.33\",\n\"ActiveEnergy\":\"232.5\",\n\"RestingEnergy\":\"\(summaryData?.heartRateResting?.value ?? 0)\",\n\"StairsClimbed\":\"33.5\"\n    },\n    \"BodeMeasurements\" : {\n\"Weight\":\"34\",\n\"Height\":\"23\"\n    },\n     \"Hearing\" : {\n        \"AudioLevels\":\"ok\"\n    }, \"Heart\" : {\n        \"HeartRate\":\"\(summaryData?.heartRate?.value ?? 0)\"\n    }, \"MentalWellbeing\" : {\n        \n    }, \"Mobility\" : {\n        \"WalkingSteadliness\":\"OK\",\n        \"DoubleSupportTime\":\"343.7\",\n        \"WalkingAsymmetry\":\"0.43\",\n        \"WalkingSpeed\":\"44.3\",\n        \"WalkingStepLength\":\"3545\"\n    }, \"Respiratory\" : {\n        \n    }, \"Symptoms\" : {\n        \n    }, \"Vitals\" : {\n        \"HeartRate\":\"\(summaryData?.walkingHeartRate?.value ?? 0)\"\n    }\n    \n\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "http://mht.demospace.cloud/api/process-data")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
            
        }

        task.resume()

    }
    
}

//MARK: - Tableview Delegate and Datasources implementation -

extension SummaryVC: UITableViewDelegate, UITableViewDataSource {
    
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
}

// MARK: - UI related setup
extension SummaryVC {
    
    private func setupInitialUI() {
        
        tblViewSummary.delegate = self
        tblViewSummary.dataSource = self

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
