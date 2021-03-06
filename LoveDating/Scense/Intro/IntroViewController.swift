//
//  IntroViewController.swift
//  LoveDating
//
//  Created by Tạ Thành Đạt on 4/26/19.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import LocalAuthentication
import CoreData

class IntroViewController: BaseViewController {
    
    @IBOutlet weak var maleImageView: UIImageView!
    @IBOutlet weak var femaleImageView: UIImageView!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var femaleView: UIView!
    @IBOutlet weak var maleView: UIView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var maleTextField: UITextField!
    @IBOutlet weak var femaleTextField: UITextField!
    @IBOutlet weak var yearBornView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeCurrentLabel: UILabel!
    @IBOutlet weak var miniYearBornView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var yearBornLabel: UILabel!
    @IBOutlet weak var displayNameView: UIView!
    @IBOutlet weak var displaySkipButton: UIButton!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    let transition = CircularTransition()
    var isSkip: Bool = true
    var gender: String = "nữ"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: METHODS
    override func setupView() {
        genderView.layer.cornerRadius = genderView.frame.height/2
        genderView.layer.masksToBounds = true
        maleView.isHidden = true
        skipButton.setBorderButton(.white)
        skipButton.tintColor = .white
        displaySkipButton.setBorderButton(.white)
        displaySkipButton.tintColor = .white
        femaleButton.setBorderButton(.originBackground)
        miniYearBornView.setRadiusView(miniYearBornView.frame.height/2)
        timeCurrentLabel.text = timeCurrentLabel.text?.getDateTimeCurrent()
        slider.maximumValue = Float(timeCurrentLabel.text!.getDateTimeCurrent())!
        slider.minimumValue = 1945
        yearBornLabel.text = String(Int(slider.value))
        femaleTextField.attributedPlaceholder = NSAttributedString(string: "Nhập tên nữ",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        maleTextField.attributedPlaceholder = NSAttributedString(string: "Nhập tên nam",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        femaleImageView.setRadiusView(femaleImageView.frame.height/2)
        femaleImageView.image = UIImage.gifImageWithName(name: "girlandcat")
        maleImageView.setRadiusView(maleImageView.frame.height/2)
        maleImageView.image = UIImage.gifImageWithName(name: "manGif")
    }
    
    override func setupNav() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
    }
    
    func checkLayout() {
        
    }
    
    //animate transition ping
    func setupGenderView(_ female: UIView,_ male: UIView, _ femaleButton: UIButton,_ maleButton: UIButton,_ color1: UIColor,_ color2: UIColor,_ color3: UIColor,_ color4: UIColor) {
        femaleButton.titleLabel?.textColor = color1
        maleButton.titleLabel?.textColor = color2
        femaleButton.setBorderButton(color3)
        maleButton.setBorderButton(color4)
        female.isHidden = true
        male.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        femaleImageView.removeFromSuperview()
    }
    //MARK: ACTIONS
    @IBAction func onSelectFemalePressed(_ sender: UIButton) {
        gender = "nữ"
        setupGenderView(maleView, femaleView, femaleButton, maleButton, .black, .lightGray, .originBackground, .white)
        transition.animate(toView: femaleView, fromTriggerButton: maleButton)
    }
    
    @IBAction func onSelectMalePressed(_ sender: UIButton) {
        gender = "nam"
        setupGenderView(femaleView, maleView, femaleButton, maleButton, .lightGray, .black, .white, .maleColor)
        transition.animate1(toView: maleView, fromTriggerButton: maleButton)
    }
    
    @IBAction func onNextPressed(_ sender: Any) {
        if !(femaleTextField.text?.trim().isEmpty)!, !(maleTextField.text?.trim().isEmpty)! {
            femaleTextField.resignFirstResponder()
            maleTextField.resignFirstResponder()
            if isSkip {
                titleLabel.text = "YearBorn"
                yearBornView.isHidden = false
                transition.animate(toView: yearBornView, fromTriggerButton:  maleButton)
                isSkip = false
            } else {
                titleLabel.text = "DisplayName"
                displayNameView.isHidden = false
                skipButton.isHidden = true
                transition.animate(toView: displayNameView, fromTriggerButton:  maleButton)
            }
        } else {
            toast("Xin hãy nhập tên của 2 bạn.")
        }
    }
    
    @IBAction func onSliderPressed(_ sender: Any) {
        DispatchQueue.main.async {
            self.yearBornLabel.text = String(Int(self.slider.value))
        }
    }
    
    @IBAction func onDisplaySkipPressed(_ sender: Any) {
        if !(displayNameTextField.text?.trim().isEmpty)! {
            SaveCoreData.shared.saveUserData(displayNameTextField.text!, gender, "", "", String(Int(slider.value)))
            DataManager.save(object: displayNameTextField.text!, forKey: Constants.kUserDefault)
            let homeVC = HomeViewController.initWithDefaultNib()
            self.navigationController?.pushViewController(homeVC, animated: true)
            //evaluatePolicy()
        } else {
            toast("Xin hãy nhập tên của bạn")
        }
    }
    
    //rotate viewcontroller
}


