
import UIKit
import MapKit
protocol LocationAddedDelegate: class {
    func locationAdded()
}
class AddLocationViewController: UIViewController , MKMapViewDelegate {
    
    // MARK: - User interface objects
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var selectedLocationLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - ViewController properties
    /// fetching marker alert flag saved in user defaults (wether to display first time alert or not)
    var isAlertDisabled: Bool = UserDefaults.standard.bool(forKey: UserDefaults.disableMarkerAlertKey)
    /// delegate
    weak var delegate: LocationAddedDelegate?
    /// Map related
    var changedLocation: String? = ""
    var annotation = MKPointAnnotation()
    var alreadyGotLocation = false
    var selecetdLat: Double = 20.5937
    var selecetdLong: Double = 78.9629
    // MARK: - ViewController delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showMarkerAlert()
        selectedLocationLabel.isHidden = true
        showMapWithLocation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.showMarkerAlert()
    }

    // MARK: - Button Actions
    @IBAction func didTapOnCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapOnAddButton(_ sender: Any) {
        self.confirmAndAddLocation()
    }
    
    // MARK: - Utilities
    func showMapWithLocation() {
        mapView.mapType = MKMapType.standard
        mapView.delegate = self
        let cl: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: selecetdLat , longitude: selecetdLong )
        setUpMapWithLocation(location: cl)
    }
    func showMarkerAlert() {
        if !isAlertDisabled {
            self.showAlert(title: "Drag and drop pin to bookmark location", message: "", actionTitle: "Okay")
            UserDefaults.disableMarkerAlert()
        }
    }
    /// taking confirmation from user before adding location
    private func confirmAndAddLocation() {
        // Create the alert controller
        let alertController = UIAlertController(title: "Are you sure, you want to add this location.?", message: changedLocation, preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.saveLocationToLocalDB()
        }
        let noAction = UIAlertAction(title: "No", style: UIAlertAction.Style.default) {_ in
        }
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(noAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    private func saveLocationToLocalDB() {
        CoreDataManager.shared.saveLocation(name: self.changedLocation ?? "", lat: self.selecetdLat, long: self.selecetdLong,
                                            completionHandler: { (success) -> Void in
                                                if success {
                                                    self.delegate?.locationAdded()
                                                    self.dismiss(animated: true, completion: nil)
                                                } else {
                                                    self.showAlert(title: "", message: "Failed to save Location, Please try again", actionTitle: "Okay")
                                                }
                                            })
    }
    // MARK: - Map Drag and Drop
    func setUpMapWithLocation(location:CLLocationCoordinate2D){
        if(alreadyGotLocation == false){
        //add your draggable annotation
        let annotation = DragMarker(coordinate: location)
            mapView.addAnnotation(annotation)
            alreadyGotLocation = true
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var pin: MKAnnotationView? = (mapView.dequeueReusableAnnotationView(withIdentifier: "myMarker"))
        if pin == nil {
            pin = MKAnnotationView(annotation: annotation, reuseIdentifier: "myMarker")
        }
        else {
            pin?.annotation = annotation
        }
        pin?.image = UIImage(named: "dragableMapIcon")
       // pin?.animatesDrop = true
        pin?.isDraggable = true
        return pin!
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        setUpMapWithLocation(location: view.annotation!.coordinate)
        self.selecetdLat = view.annotation!.coordinate.latitude
        self.selecetdLong = view.annotation!.coordinate.longitude
        let loc: CLLocation = CLLocation(latitude: view.annotation!.coordinate.latitude, longitude: view.annotation!.coordinate.longitude)
        self.convertLatLongToAddress(location: loc)
    }
    /// Convert Lat and Long to address
    private func convertLatLongToAddress(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [self] (placemarks, error) in
            if (error != nil){
                printObj(object: "error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0 {
                let placemark = placemarks![0]
                var address: String = ""
                if let name = placemark.name {
                    address.append(name)
                    address.append(", ")
                }
                if let locality = placemark.locality {
                    address.append(locality)
                    address.append(", ")
                }
                if let adminiArea = placemark.administrativeArea {
                    address.append(adminiArea)
                    address.append(", ")
                }
                if let country = placemark.country {
                    address.append(country)
                }
                self.changedLocation = address
                self.selectedLocationLabel.isHidden = false
                self.selectedLocationLabel.layer.cornerRadius = 8.0
                self.selectedLocationLabel.layer.masksToBounds = true
                self.selectedLocationLabel.text = " \(changedLocation ?? "")"
            }
        }
    }
    
}
