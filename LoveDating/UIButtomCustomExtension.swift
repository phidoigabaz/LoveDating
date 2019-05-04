//
//  UIButtomCustomExtension.swift
//  FramesLayout
//
//  Created by GEM on 4/5/19.
//  Copyright © 2019 dattt. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setRadiusButton(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setBorderButton(_ borderColor: UIColor) {
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.borderWidth = 2.5
        self.layer.borderColor = borderColor.cgColor
    }
}
