//
//  CoinData.swift
//  ByteCoin
//
//  Created by Sanjay Singh on 05/07/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    var rate: Double
    var asset_id_quote: String
}
