

import Foundation
struct Minutely : Codable {
	let dt : Int?
	let precipitation : Int?

	enum CodingKeys: String, CodingKey {

		case dt = "dt"
		case precipitation = "precipitation"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dt = try values.decodeIfPresent(Int.self, forKey: .dt)
		precipitation = try values.decodeIfPresent(Int.self, forKey: .precipitation)
	}

}
