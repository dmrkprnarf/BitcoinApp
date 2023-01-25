//
//  BitcoinMenager.swift
//  BitcoinApp
//
//  Created by Arif Demirkoparan on 25.01.2023.
//

import Foundation


protocol BitcoinMenagerDelegate {
    func updatePrice(price:String)
    func didFailWithError(error: Error)
}

struct BitcoinMenager {
    
    var delegate:BitcoinMenagerDelegate?
    var bitcoinURL = "https://rest.coinapi.io/v1/exchangerate/"
    var APIKey = "D1CB647D-F82E-4416-A0A3-B1E5D6DE26B6"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    func fetchBitcoin(bitcoinName:String) {
        let bitcoinURL = "\(bitcoinURL)\(bitcoinName)?apikey=\(APIKey)"
        performRequest(bitcoinURL: bitcoinURL)
    }
    
    func performRequest(bitcoinURL:String) {
        if let url = URL(string: bitcoinURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                }
                if  let safeData = data {
                    let bitcoin = self.parseJSON(bitcoinData: safeData)
                    if let safeBitcoin = bitcoin {
                        let urlPrice = String(format: "%.2f", safeBitcoin)
                        delegate?.updatePrice(price: urlPrice)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON (bitcoinData:Data) -> Double?{
        var doubleValue:Double?
        let decoder = JSONDecoder()
        
        do{
            let parsingData = try decoder.decode(BitcoinData.self, from: bitcoinData)
            for i in 0..<parsingData.rates.count {
                doubleValue = parsingData.rates[i].rate
            }
            return doubleValue
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
            
        }
    }
}
