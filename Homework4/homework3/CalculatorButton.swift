//
//  CalculatorButton.swift
//  homework3
//
//  Created by Xcode User on 10/1/19.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit

class CalculatorButton: UIButton {

    override func awakeFromNib() {
        self.backgroundColor = FOREGROUND_COLOR
        self.layer.cornerRadius = 6.0
        self.setTitleColor(BACKGROUND_COLOR, for: .normal)
    }

}
