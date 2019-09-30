//
//  SettingsViewController.swift
//  homework3
//
//  Created by Xcode User on 9/23/19.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func settingsChanged(fromUnits: String, toUnits: String)
}



class SettingsViewController: UIViewController {
    
    var delegate: SettingsViewControllerDelegate?
    
    //variables for passed in data
    var mode: CalculatorMode = CalculatorMode.Length
    var fromUnitsText = ""
    var toUnitsText = ""

    var pickerData: [String] = [String]()
    var selection : String = "DOES THIS WORK"
    
    var fromIsPressed: Bool = false
    var toIsPressed: Bool = false
    
    @IBOutlet weak var fromUnits: UILabel!
    @IBOutlet weak var toUnits: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if mode == CalculatorMode.Length {
            self.pickerData = ["Meters", "Yards", "Miles"]
        }
        else {
            self.pickerData = ["Liters", "Gallons", "Quarts"]
        }
        //self.pickerData = ["option 1", "option 2", "option 3"]
        self.picker.delegate = self
        self.picker.dataSource = self
        
        self.fromUnits.text = fromUnitsText
        self.toUnits.text = toUnitsText
        
        let tapFrom = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.tapFunctionFrom))
        fromUnits.isUserInteractionEnabled = true
        fromUnits.addGestureRecognizer(tapFrom)
        
        let tapTo = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.tapFunctionTo))
        toUnits.isUserInteractionEnabled = true
        toUnits.addGestureRecognizer(tapTo)
        
        picker.isHidden = true
        
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dismissPicker))
        self.view.addGestureRecognizer(detectTouch)
        

    }
    
    @objc func dismissPicker(){
        if fromIsPressed == true{
            fromUnits.text = self.selection
        }
        else if toIsPressed == true{
            toUnits.text = self.selection
        }
        picker.isHidden = true
    }
    
    @IBAction func tapFunctionFrom(sender: UITapGestureRecognizer) {
        self.fromIsPressed = true
        self.toIsPressed = false
        picker.isHidden = false
    }
    
    @IBAction func tapFunctionTo(sender: UITapGestureRecognizer) {
        self.toIsPressed = true
        self.fromIsPressed = false
        picker.isHidden = false
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        if let d = self.delegate{
            d.settingsChanged(fromUnits: String(fromUnits.text!), toUnits: String(toUnits.text!))
        }
        
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}

extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selection = self.pickerData[row]
    }
}
