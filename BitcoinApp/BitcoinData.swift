// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let bitcoinData = try? JSONDecoder().decode(BitcoinData.self, from: jsonData)

import Foundation

// MARK: - BitcoinData
struct BitcoinData: Codable {
    let rates: [Rate]
}

struct Rate: Codable {
    let rate: Double
}
