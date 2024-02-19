
import UIKit
//HealthCategoriesTVCell
class BrowseCategoriesVC: BaseViewController {
   
    
    @IBOutlet private var tblViewCategories: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var userImageView: UIImageView!
    
    var records = BrowseRecords.browsercategoriesRecord
    var selectIndx: Int = 0
    
  //  private let viewModel = BrowseCategoriesVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewCategories.delegate = self
        tblViewCategories.dataSource = self
        tblViewCategories.register(UINib(nibName: "HealthCategoriesTVCell", bundle: nil), forCellReuseIdentifier: "HealthCategoriesTVCell")
        customeTblViewBorder()
        customView(view: userImageView)
        tblViewCategories.reloadData()
    }
 
    //MARK: do not tuch it
    override func bindViewModel() {
        
    }
    
    func customView(view: UIView){
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
    }
    
    func customeTblViewBorder(){
        tblViewCategories.layer.cornerRadius = 5
        tblViewCategories.clipsToBounds = true
    }
    
}


extension BrowseCategoriesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewCategories.dequeueReusableCell(withIdentifier: "HealthCategoriesTVCell", for: indexPath) as! HealthCategoriesTVCell
        
        cell.titleLbl.text = records[indexPath.row].title
        cell.titleIMG.image = records[indexPath.row].image
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndx = indexPath.row
        
        if indexPath.row == 0 {
    
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActivityVC") as! ActivityVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        if indexPath.row == 1 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HeartRateVC") as! HeartRateVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        if indexPath.row == 2 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BodyMeasurementsVC") as! BodyMeasurementsVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        if indexPath.row == 3 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VitalsVC") as! VitalsVC
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
        
        if indexPath.row == 4 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MentalWellbeingVC") as! MentalWellbeingVC
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
        if indexPath.row == 5 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MobilityVC") as! MobilityVC
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
        if indexPath.row == 6 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RespiratoryVC") as! RespiratoryVC
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
        if indexPath.row == 7 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SleepVC") as! SleepVC
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
        if indexPath.row == 8 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HearingVC") as! HearingVC
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
    }
    
    
    
}


/*
extension BrowseCategoriesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = viewModel.itemForIndex(indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
        
        cell.textLabel?.text = item.title
        cell.imageView?.image = item.image
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO:
    }
} */
