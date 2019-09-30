//
//  ViewController.swift
//  homework3
//
//  Created by Xcode User on 9/18/19.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, SettingsViewControllerDelegate {

    @IBOutlet weak var fromTextField: DecimalMinusTextField!
    
    @IBOutlet weak var toTextField: DecimalMinusTextField!
    
    @IBOutlet weak var fromUnits: UILabel!
    
    @IBOutlet weak var toUnits: UILabel!
    
    var mode: CalculatorMode = CalculatorMode.Length
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
        
        self.fromTextField.delegate = self
        self.toTextField.delegate = self
        
    }
    
    
    func settingsChanged(fromUnits: String, toUnits: String){
        self.fromUnits.text = fromUnits
        self.toUnits.text = toUnits
    }
        
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if(segue.identifier == "settingsSegue"){
            if let dest = segue.destination.children[0] as? SettingsViewController{
                dest.delegate = self
                //sets the settings screen initial units to the current units in the main view
                dest.mode = self.mode
                dest.fromUnitsText = String(self.fromUnits.text!)
                dest.toUnitsText = String(self.toUnits.text!)
            //}
        }
    }
    
    @IBAction func calculateClick(_ sender: Any) {
        var valueToConvert: Double
        var convertedValue: Double
        
        dismissKeyboard()
        
        if fromTextField.text != ""{
            
            valueToConvert = Double(fromTextField.text!)!
            
            if self.mode == CalculatorMode.Length {
            
                let convKey =  LengthConversionKey(toUnits: String(toUnits.text!), fromUnits: String(fromUnits.text!))
                convertedValue = valueToConvert * lengthConversionTable[convKey]!;
            
            toTextField.text = String(convertedValue)
            }
            
            else{
                let convKey =  VolumeConversionKey(toUnits: String(toUnits.text!), fromUnits: String(fromUnits.text!))
                convertedValue = valueToConvert * volumeConversionTable[convKey]!;
                
                toTextField.text = String(convertedValue)
                
            }
        }
            
        else if toTextField.text != ""{
            //set yards textfield
            valueToConvert = Double(toTextField.text!)!
            
            if self.mode == CalculatorMode.Length {
                
                let convKey =  LengthConversionKey(toUnits: String(fromUnits.text!), fromUnits: String(toUnits.text!))
                convertedValue = valueToConvert * lengthConversionTable[convKey]!;
                
                
                fromTextField.text = String(convertedValue)
            }
            
            else{
                
                let convKey =  VolumeConversionKey(toUnits: String(fromUnits.text!), fromUnits: String(toUnits.text!))
                convertedValue = valueToConvert * volumeConversionTable[convKey]!;
                
                
                fromTextField.text = String(convertedValue)
            }
        
            
        }
        else{
            print("Please enter a value to convert")
        }
    }
    
    
    @IBAction func clearClick(_ sender: Any) {
        fromTextField.text = ""
        toTextField.text = ""
    }
    
    @IBAction func modeClick(_ sender: Any) {
        
        if mode == CalculatorMode.Length{
            mode = CalculatorMode.Volume
            fromUnits.text = "Gallons"
            toUnits.text = "Liters"
        }
        else{
            mode = CalculatorMode.Length
            fromUnits.text = "Yards"
            toUnits.text = "Meters"
        }
    }
    

    @IBAction func settingsClick(_ sender: Any) {
        
    }
    
}


extension ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == self.fromTextField){
            self.toTextField.text = ""
        }
        else{
            self.fromTextField.text = ""
        }
    }
}

enum CalculatorMode : String {
    case Length
    case Volume
}
enum LengthUnit : String, CaseIterable {
    case Meters = "Meters"
    case Yards = "Yards"
    case Miles = "Miles"
}

enum VolumeUnit : String, CaseIterable {
    case Liters = "Liters"
    case Gallons = "Gallons"
    case Quarts = "Quarts"
}

struct LengthConversionKey : Hashable {
    var toUnits : String
    var fromUnits : String
}

// The following tables let you convert between units with a simple dictionary lookup. For example, assume
// that the variable fromVal holds the value you are converting from:
//
//      let convKey =  LengthConversionKey(toUnits: .Miles, fromUnits: .Meters)
//      let toVal = fromVal * lengthConversionTable[convKey]!;

let lengthConversionTable : Dictionary<LengthConversionKey, Double> = [
    LengthConversionKey(toUnits: "Meters", fromUnits: "Meters") : 1.0,
    LengthConversionKey(toUnits: "Meters", fromUnits: "Yards") : 0.9144,
    LengthConversionKey(toUnits: "Meters", fromUnits: "Miles") : 1609.34,
    LengthConversionKey(toUnits: "Yards", fromUnits: "Meters") : 1.09361,
    LengthConversionKey(toUnits: "Yards", fromUnits: "Yards") : 1.0,
    LengthConversionKey(toUnits: "Yards", fromUnits: "Miles") : 1760.0,
    LengthConversionKey(toUnits: "Miles", fromUnits: "Meters") : 0.000621371,
    LengthConversionKey(toUnits: "Miles", fromUnits: "Yards") : 0.000568182,
    LengthConversionKey(toUnits: "Miles", fromUnits: "Miles") : 1.0
]

struct VolumeConversionKey : Hashable {
    var toUnits : String
    var fromUnits : String
}

let volumeConversionTable : Dictionary<VolumeConversionKey, Double> = [
    VolumeConversionKey(toUnits: "Liters", fromUnits: "Liters") : 1.0,
    VolumeConversionKey(toUnits: "Liters", fromUnits: "Gallons") : 3.78541,
    VolumeConversionKey(toUnits: "Liters", fromUnits: "Quarts") : 0.946353,
    VolumeConversionKey(toUnits: "Gallons", fromUnits: "Liters") : 0.264172,
    VolumeConversionKey(toUnits: "Gallons", fromUnits: "Gallons") : 1.0,
    VolumeConversionKey(toUnits: "Gallons", fromUnits: "Quarts") : 0.25,
    VolumeConversionKey(toUnits: "Quarts", fromUnits: "Liters") : 1.05669,
    VolumeConversionKey(toUnits: "Quarts", fromUnits: "Gallons") : 4.0,
    VolumeConversionKey(toUnits: "Quarts", fromUnits: "Quarts") : 1.0
]

// To support Swift 4.2's iteration over enum... see
// source: https://stackoverflow.com/questions/24007461/how-to-enumerate-an-enum-with-string-type
#if !swift(>=4.2)
public protocol CaseIterable {
    associatedtype AllCases: Collection where AllCases.Element == Self
    static var allCases: AllCases { get }
}
extension CaseIterable where Self: Hashable {
    static var allCases: [Self] {
        return [Self](AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            var first: Self?
            return AnyIterator {
                let current = withUnsafeBytes(of: &raw) { $0.load(as: Self.self) }
                if raw == 0 {
                    first = current
                } else if current == first {
                    return nil
                }
                raw += 1
                return current
            }
        })
    }
}

#endif
