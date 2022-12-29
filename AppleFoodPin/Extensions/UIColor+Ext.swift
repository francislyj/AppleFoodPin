//
//  UIColor+Ext.swift
//  AppleFoodPin
//
//  Created by user on 2022/12/29.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let redValue = CGFloat(red) / 255
        let greenValue = CGFloat(green) / 255
        let blueValue = CGFloat(blue) / 255
        
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
}
