
import UIKit
import AtasApiFramework

class ViewController: UIViewController {
    // MARK: - User interface objects
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addLocationButton: UIButton!
    @IBOutlet weak var weatherTableView: UITableView!
    /// Search Bar
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextfield: UITextField!

    
    // MARK: - ViewController properties
    let refreshControl = UIRefreshControl()
    var bookmarkedLocationsArrayFromDB: [Locations]?
    var bookmarkedLocations: [Locations] = [] {
        didSet {
            weatherTableView.reloadData()
        }
    }
    
    // MARK: - ViewController delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchBookmarkedLocations()
    }
    // MARK: - Utilities
    private func initialSetup(){
        registerNib()
        weatherTableView.allowsSelectionDuringEditing = true
        addRefreshControl()
        searchTextfield.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
       // self.hideKeyboardWhenTappedAround()
    }
    
    /// register nibs
    private func registerNib() {
        weatherTableView.register(UINib(nibName: HomeLocationsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: HomeLocationsTableViewCell.identifier)
    }
    private func addRefreshControl() {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "textColot")]
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Bookmarked Locations...!", attributes: attributes as [NSAttributedString.Key : Any])
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(named: "textColot")
        weatherTableView.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: AnyObject) {
        self.fetchBookmarkedLocations()
        refreshControl.endRefreshing()
    }
    private func fetchBookmarkedLocations() {
        CoreDataManager.shared.fetchAllBookmarkedLocations(completionHandler: { (locations) -> Void in
            if locations.count > 0 {
                searchView.isHidden = false
            } else {
                searchView.isHidden = true
            }
            self.bookmarkedLocationsArrayFromDB = locations
            self.bookmarkedLocations = locations
        })
    }
    // Search field text change method to filter locations
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text == "" {
            self.bookmarkedLocations = bookmarkedLocationsArrayFromDB ?? []
        } else {
            let filterdTerms = self.bookmarkedLocationsArrayFromDB?.filter { term in
                return term.name!.lowercased().contains((textField.text?.lowercased())!)
            }
            self.bookmarkedLocations = filterdTerms ?? []
        }
    }
    
    // MARK: - Button Actions
    @IBAction func didTapOnAddLocation(_ sender: Any) {
        let addLocationViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
        addLocationViewController.delegate = self
        self.present(addLocationViewController, animated:true, completion: nil)
    }
    // Textfield action to dismiss keyboard when return key pressed
    @IBAction func didPressReturnKey(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
}

// MARK: - TableView DataSource Methods
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bookmarkedLocations.count == 0 {
            tableView.setFallbackView(withTitle: "Oops!",withText: "No Bookmarked Locations found\n Please add locations to display here")
            return 0
        } else {
            tableView.restore()
            return bookmarkedLocations.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locationCell = tableView.dequeueReusableCell(withIdentifier: HomeLocationsTableViewCell.identifier) as? HomeLocationsTableViewCell
        locationCell?.locationData = bookmarkedLocations[indexPath.row]
        locationCell?.selectionStyle = .none
        return locationCell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            CoreDataManager.shared.deleteSavedLocation(name: bookmarkedLocations[indexPath.row].name ?? "")
            self.fetchBookmarkedLocations()
        }
    }
}
// MARK: - TableView Delegate Methods
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(identifier: "HomeDetailsViewController") as! HomeDetailsViewController
        detailsVC.selectedLat = bookmarkedLocations[indexPath.row].lattitude
        detailsVC.selectedLong = bookmarkedLocations[indexPath.row].longitude
        detailsVC.selectedArea = bookmarkedLocations[indexPath.row].name
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
// MARK: - LocationAddedDelegate
extension ViewController: LocationAddedDelegate {
    func locationAdded() {
        self.fetchBookmarkedLocations()
    }
}
