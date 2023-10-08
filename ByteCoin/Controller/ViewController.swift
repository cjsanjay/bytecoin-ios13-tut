//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitCoinLabel: UILabel!
    
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinManager.delegate = self
        currencyLabel.text = coinManager.currencyArray[0]
        coinManager.getCoinPrice(currency: coinManager.currencyArray[0])
    }
}

extension ViewController: CoinManagerDelegate {
    func didFailWithError(_ error: Error) {
        print (error)
    }
    
    func didUpdateCoinData(_ coinmanager: CoinManager, coinModel: CoinModel) {
        print ("coid model data", coinModel.currentRate)
        DispatchQueue.main.async {
            self.bitCoinLabel.text = String(format: "%0.2f", coinModel.currentRate)
        }
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyLabel.text = coinManager.currencyArray[row]
        coinManager.getCoinPrice(currency: coinManager.currencyArray[row])
    }
}

