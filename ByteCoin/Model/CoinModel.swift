//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Sanjay Singh on 05/07/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel: Decodable {
    var currencyName: String
    var currentRate: Double
}
