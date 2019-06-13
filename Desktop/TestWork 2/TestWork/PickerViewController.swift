//
//  PickerViewController.swift
//  TestWork
//
//  Created by Anastasia on 6/7/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var numberPicker: UIPickerView!
    @IBOutlet var letterPicker: UIPickerView!
    @IBOutlet var resultLabel: UILabel!
    
    var arrayOfNumbers: [NSInteger] = [NSInteger]()
    var arrayOfLetters: [UnicodeScalar] = [UnicodeScalar]()
    var selectedNumber: Int = 1
    var selectedLetter: String = "A"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.numberPicker.delegate = self
        self.numberPicker.dataSource = self
        
        self.letterPicker.delegate = self
        self.letterPicker.dataSource = self
        
        fillArrays()
        showSelecedOptions(selectedNumber: selectedNumber, selectedLetter: selectedLetter)
    }
    
    func fillArrays(){
        for value in 1...100 {
            arrayOfNumbers.append(value)
        }
        
        for value in UnicodeScalar("A").value...UnicodeScalar("Z").value {
            arrayOfLetters.append(UnicodeScalar(value)!)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == numberPicker{
            return arrayOfNumbers.count
        } else {
            return arrayOfLetters.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == numberPicker {
            return "\(arrayOfNumbers[row])"
        } else {
            return "\(arrayOfLetters[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == numberPicker {
            selectedNumber = arrayOfNumbers[row]
        } else {
            selectedLetter = "\(arrayOfLetters[row])"
        }
        showSelecedOptions(selectedNumber: selectedNumber, selectedLetter: selectedLetter)
    }
    
    func showSelecedOptions(selectedNumber: Int, selectedLetter: String){
        resultLabel.text = "You chose number: \(selectedNumber), letter: \(selectedLetter)"
    }
}
