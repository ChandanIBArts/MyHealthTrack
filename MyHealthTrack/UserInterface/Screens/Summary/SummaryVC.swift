
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
