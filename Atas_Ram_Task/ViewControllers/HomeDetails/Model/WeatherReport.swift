import Foundation
struct WeatherReport : Codable {
	let lat : Double?
	let lon : Double?
	let timezone : String?
	let timezone_offset : Int?
	let current : Current?
	let minutely : [Minutely]?
	let hourly : [Hourly]?
	let daily : [Daily]?

	enum CodingKeys: String, CodingKey {

		case lat = "lat"
		case lon = "lon"
		case timezone = "timezone"
		case timezone_offset = "timezone_offset"
		case current = "current"
		case minutely = "minutely"
		case hourly = "hourly"
		case daily = "daily"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		lat = try values.decodeIfPresent(Double.self, forKey: .lat)
		lon = try values.decodeIfPresent(Double.self, forKey: .lon)
		timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
		timezone_offset = try values.decodeIfPresent(Int.self, forKey: .timezone_offset)
		current = try values.decodeIfPresent(Current.self, forKey: .current)
		minutely = try values.decodeIfPresent([Minutely].self, forKey: .minutely)
		hourly = try values.decodeIfPresent([Hourly].self, forKey: .hourly)
		daily = try values.decodeIfPresent([Daily].self, forKey: .daily)
	}

}
