
import UIKit
//HealthCategoriesTVCell
class BrowseCategoriesVC: BaseViewController {
   
    
    @IBOutlet private var tblViewCategories: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var userImageView: UIImageView!
    
    var records = BrowseRecords.browsercategoriesRecord
    var selectIndx: Int = 0
    var filterData = [BrowseRecords]()
  //  private let viewModel = BrowseCategoriesVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterData = records
        tblViewCategories.delegate = self
        tblViewCategories.dataSource = self
        tblViewCategories.register(UINib(nibName: "HealthCategoriesTVCell", bundle: nil), forCellReuseIdentifier: "HealthCategoriesTVCell")
        customeTblViewBorder()
        customView(view: userImageView)
        tblViewCategories.reloadData()
        tblViewCategories.backgroundColor = .clear
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


extension BrowseCategoriesVC: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewCategories.dequeueReusableCell(withIdentifier: "HealthCategoriesTVCell", for: indexPath) as! HealthCategoriesTVCell
        cell.titleLbl.text = filterData[indexPath.row].title
        cell.titleIMG.image = filterData[indexPath.row].image
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
        if searchText != "" {
            filterData = records.filter{ $0.title?.contains(searchText) ?? false }
            tblViewCategories.reloadData()
        } else {
            filterData = records
            tblViewCategories.reloadData()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndx = indexPath.row
        
        if filterData[indexPath.row].title == "Activity" {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActivityVC") as! ActivityVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        if filterData[indexPath.row].title == "Heart" {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HeartRateVC") as! HeartRateVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        if filterData[indexPath.row].title == "Body measurement" {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BodyMeasurementsVC") as! BodyMeasurementsVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        if filterData[indexPath.row].title == "Vitals" {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VitalsVC") as! VitalsVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        if filterData[indexPath.row].title == "Mental" {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MentalWellbeingVC") as! MentalWellbeingVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        if filterData[indexPath.row].title == "Mobility" {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MobilityVC") as! MobilityVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
        if filterData[indexPath.row].title == "Respiratory" {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RespiratoryVC") as! RespiratoryVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        if filterData[indexPath.row].title == "Sleep" {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SleepVC") as! SleepVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
        if filterData[indexPath.row].title == "Hearing" {
            
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
