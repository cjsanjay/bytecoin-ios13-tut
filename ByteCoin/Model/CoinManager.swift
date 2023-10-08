//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol   {
    func didFailWithError(_ error: Error)
    func didUpdateCoinData(_ coinmanager: CoinManager, coinModel: CoinModel)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "D53DBEF4-312A-410C-809A-3F206B45473E"
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(currency: String) {
        print ("get coin price")
        if let url = URL(string: "\(baseURL)/\(currency)?apiKey=\(apiKey)") {
            print ("get coin price api url", url)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    print (error!)
                    self.delegate?.didFailWithError(error!)
                    return
                    
                }
                if let safedata = data {
                    if let coinModel = self.parseJson(safedata) {
                        self.delegate?.didUpdateCoinData(self, coinModel: coinModel)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ data: Data) -> CoinModel? {
        let jsonDecoder = JSONDecoder()
        do {
            let decodedData = try jsonDecoder.decode(CoinData.self, from: data)
            print ("Got coin data:", decodedData.rate)
            return CoinModel(currencyName: decodedData.asset_id_quote, currentRate: decodedData.rate)
            
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
