
import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var daysCollectionView: UICollectionView!

    var weatherData: WeatherReport? {
        didSet {
            daysCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.daysCollectionView.register(UINib(nibName: "DatesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DatesCollectionViewCell")
        daysCollectionView.dataSource = self
        daysCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    /**
     *
     * Convert unix time to human readable time. Return empty string if unixtime
     * argument is 0. Note that EMPTY_STRING = ""
     *
     * @param unixdate the time in unix format, e.g. 1482505225
     * @param timezone the user's time zone, e.g. EST, PST
     * @return the date and time converted into human readable String format
     *
     **/
    func getDate(unixdate: Int, timezone: String, dateFormat: String = "MMM d") -> String {
        if unixdate == 0 {return ""}
        let date = NSDate(timeIntervalSince1970: TimeInterval(unixdate))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = dateFormat
        dayTimePeriodFormatter.timeZone = NSTimeZone(name: timezone) as TimeZone?
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return "\(dateString)"
    }
}
extension DailyWeatherTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData?.daily?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatesCollectionViewCell", for: indexPath) as? DatesCollectionViewCell
        cell?.dateLabel.text = self.getDate(unixdate: weatherData?.daily?[indexPath.item].dt ?? 0, timezone: "IST")
        if weatherData?.daily?[indexPath.item].weather?.count ?? 0 > 0 {
        let imageUrl = ImageServiceUrlEndpoint.getWeatherImage(name: weatherData?.daily?[indexPath.item].weather?[0].icon ?? "").url()
            cell?.weatherImageView.loadImageFromServerURL(imageUrl, placeHolder: UIImage())
            cell?.tempDescriptionLabel.text = weatherData?.daily?[indexPath.item].weather?[0].main
        }
        cell?.tempLabel.text = "\(weatherData?.daily?[indexPath.row].temp?.min ?? 0)\(GetExtensionMetric.getMetric.type())" + "/" + "\(weatherData?.daily?[indexPath.row].temp?.max ?? 0)\(GetExtensionMetric.getMetric.type())"
        
        return cell!
    }
}

extension DailyWeatherTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 130)
    }
}
