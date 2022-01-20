
import UIKit

class AddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempDescriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    var selectedArea: String?
    var weatherData: WeatherReport? {
        didSet {
            updateData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateData() {
        locationLabel.text = selectedArea
        dateTimeLabel.text = getCurrentDateAndTime()
        temperatureLabel.text = "\(weatherData?.current?.temp ?? 0)\(GetExtensionMetric.getMetric.type())"
        humidityLabel.text = "\(weatherData?.current?.humidity ?? 0)"
        feelsLikeLabel.text = "\(weatherData?.current?.feels_like ?? 0)"
        windLabel.text = "\(weatherData?.current?.wind_speed ?? 0)"
        if weatherData?.current?.weather?.count ?? 0 > 0 {
            tempDescriptionLabel.text = (weatherData?.current?.weather?[0].main ?? "") + "-" + (weatherData?.current?.weather?[0].description ?? "")
        }
    }
    func getCurrentDateAndTime() -> String {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy"
        return dateFormatter.string(from: date as Date)
    }
}
