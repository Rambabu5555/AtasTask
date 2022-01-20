
import UIKit

class HomeDetailsViewController: UIViewController {
    // MARK: - User interface objects
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
   
    @IBOutlet weak var weatherTableView: UITableView!
    
    // MARK: - ViewController properties
    var selectedLat: Double!
    var selectedLong: Double!
    var selectedArea: String?
    var viewModel = HomeDetailsViewModel(apimanager: APIManager.shared)
    // MARK: - ViewController delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNib()
        self.addShadows()
        // ------------------------------------Get weather data using urlsession----------------------- //
        // - uncomment below line to fetch data from URL session
        //  getWeatherData()
        // ------------------------------------Get weather data using Podfile----------------------- //
            getWeatherDataUsingPod()
        // ----------------------------------------------------------------------------------------- //
    }
    
    // MARK: - Utilities
    func loadNib() {
        weatherTableView.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressTableViewCell")
        weatherTableView.register(UINib(nibName: "DailyWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyWeatherTableViewCell")
        weatherTableView.register(UINib(nibName: "HourleyTableViewCell", bundle: nil), forCellReuseIdentifier: "HourleyTableViewCell")
      
    }
    
    // MARK: - Get weather data from viewmodel using URLSession
    func getWeatherData() {
        if selectedLat != nil && selectedLong != nil {
            let metricSlecetd = UserDefaults.getMetricSelected()
            viewModel.getWeatherResults(withLat: selectedLat, withLong: selectedLong, withExclude: "", units: metricSlecetd) { (status, message) in
                if status {
                    DispatchQueue.main.async {
                        self.weatherTableView.reloadData()
                    }
                } else {
                    self.showAlert(title: message ?? "", message: "", actionTitle: "Okay")
                }
            }
        }
    }
    
    // MARK: - Get weather data from viewmodel using AtasApiFramework POD
    func getWeatherDataUsingPod() {
        if selectedLat != nil && selectedLong != nil {
            let metricSlecetd = UserDefaults.getMetricSelected()
            viewModel.getWeatherResultsFromPods(withLat: selectedLat, withLong: selectedLong, withExclude: "", units: metricSlecetd) { (status, message) in
                if status {
                    DispatchQueue.main.async {
                        self.weatherTableView.reloadData()
                    }
                } else {
                    self.showAlert(title: message ?? "", message: "", actionTitle: "Okay")
                }
            }
        }
    }
    
    private func addShadows(){
        /// adding shadow to subviews
        overlayView.layer.addshadowToLayer(color: UIColor(named: "textColot")!, radius: 8)
        backButton.layer.addshadowToLayer(color: UIColor(named: "textColot")!, radius: 8)
        infoButton.layer.addshadowToLayer(color: UIColor(named: "textColot")!, radius: 8)
        settingsButton.layer.addshadowToLayer(color: UIColor(named: "textColot")!, radius: 8)
    }
    // MARK: - Button Actions
    @IBAction func ddiTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didTapOnInfoButton(_ sender: Any) {
        let infoVC = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        self.present(infoVC, animated:true, completion: nil)
    }
    @IBAction func didTapOnSettingsButton(_ sender: Any) {
        let settingsVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        settingsVC.delegate = self
        self.present(settingsVC, animated:true, completion: nil)
    }
    

}

// MARK: - TableView DataSource Methods
extension HomeDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return viewModel.weatherData?.hourly?.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let addressCell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell") as! AddressTableViewCell
                addressCell.weatherData = viewModel.weatherData
            addressCell.selectionStyle = .none
            return addressCell
        } else if indexPath.section == 1 {
            let dailyCell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherTableViewCell") as! DailyWeatherTableViewCell
                dailyCell.weatherData = viewModel.weatherData
            dailyCell.selectionStyle = .none
            return dailyCell
        } else {
            let hourlyCell = tableView.dequeueReusableCell(withIdentifier: "HourleyTableViewCell") as! HourleyTableViewCell
            if viewModel.weatherData?.hourly?[indexPath.item].weather?.count ?? 0 > 0 {
                let imageUrl = ImageServiceUrlEndpoint.getWeatherImage(name: viewModel.weatherData?.hourly?[indexPath.item].weather?[0].icon ?? "").url()
                hourlyCell.weatherImageView.loadImageFromServerURL(imageUrl, placeHolder: UIImage())
                hourlyCell.tempLabel.text = "\(viewModel.weatherData?.hourly?[indexPath.item].temp ?? 0)\(GetExtensionMetric.getMetric.type()) / \(viewModel.weatherData?.hourly?[indexPath.item].weather?[0].main ?? "")"
            }
            hourlyCell.timeLabel.text = self.getDate(unixdate: viewModel.weatherData?.hourly?[indexPath.item].dt ?? 0, timezone: "IST", dateFormat: "h:mm a")
            hourlyCell.selectionStyle = .none
            return hourlyCell
        }
    }
}
// MARK: - TableView Delegate Methods
extension HomeDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = WeatherDetailsTableHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        if section == 1 {
            headerView.sectionHeaderLabel.text = "Daily"
        } else {
            headerView.sectionHeaderLabel.text = "Hourley"
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 30
        }
    }
}
// MARK: - TableView Delegate Methods
extension HomeDetailsViewController: SettingsUpdatedDelegate {
    func settingsUpdated() {
        self.getWeatherData()
    }
}
