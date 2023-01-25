//
//  ViewController.swift
//  BitcoinApp
//
//  Created by Arif Demirkoparan on 25.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var bitcoinView: UIView!
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    var bitcoinMenager = BitcoinMenager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bitcoinMenager.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
    }
}

extension ViewController:BitcoinMenagerDelegate {
 
    func updatePrice(price: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
        }
    }
    
    func didFailWithError(error: Error) {
        print("Hata \(error.localizedDescription)")
    }
}

extension ViewController:UIPickerViewDelegate {
}

extension ViewController:UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bitcoinMenager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  bitcoinMenager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        bitcoinMenager.fetchBitcoin(bitcoinName: bitcoinMenager.currencyArray[row])
    }
}

