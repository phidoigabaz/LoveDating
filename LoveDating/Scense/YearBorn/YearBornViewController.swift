//
//  YearBornViewController.swift
//  LoveDating
//
//  Created by Tạ Thành Đạt on 5/3/19.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

class YearBornViewController: BaseViewController {

    @IBOutlet weak var yearBornView: UIView!
    @IBOutlet weak var yearBornLabel: UILabel!
    @IBOutlet weak var yearBornSlider: UISlider!
    @IBOutlet weak var yearCurrentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        //yearCurrentLabel.text = yearCurrentLabel.text?.getDateTimeCurrent()
//        yearBornSlider.maximumValue = 2019
//        yearBornSlider.minimumValue = 1945
//        yearBornView.layer.cornerRadius = yearBornView.frame.height/2
//        yearBornView.layer.masksToBounds = true
    }
    
    //MARK: ACTIONS
    @IBAction func onSliderPressed(_ sender: Any) {
        DispatchQueue.main.async {
            self.yearBornLabel.text = String(Int(self.yearBornSlider.value))
        }
    }
}
