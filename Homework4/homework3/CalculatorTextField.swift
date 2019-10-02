//
//  CalculatorTextField.swift
//  homework3
//
//  Created by Xcode User on 10/1/19.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit

class CalculatorTextField: DecimalMinusTextField {
    
    override func awakeFromNib() {
        
        //FIX_ME set placeholder text to foreground color
        
        self.backgroundColor = UIColor.clear
        
        self.layer.cornerRadius = 6.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        
        self.textColor = FOREGROUND_COLOR
        
        
    }

}
