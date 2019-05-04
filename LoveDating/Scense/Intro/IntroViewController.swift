//
//  IntroViewController.swift
//  LoveDating
//
//  Created by Tạ Thành Đạt on 4/26/19.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import LocalAuthentication

class IntroViewController: BaseViewController {
    
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var femaleView: UIView!
    @IBOutlet weak var maleView: UIView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var maleTextField: UITextField!
    @IBOutlet weak var yearBornView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeCurrentLabel: UILabel!
    @IBOutlet weak var miniYearBornView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var yearBornLabel: UILabel!
    @IBOutlet weak var displayNameView: UIView!
    @IBOutlet weak var displaySkipButton: UIButton!
    
    let transition = CircularTransition()
    var isSkip: Bool = true
    
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
        femaleButton.setBorderButton(.femaleColor)
        miniYearBornView.setRadiusView(miniYearBornView.frame.height/2)
        timeCurrentLabel.text = timeCurrentLabel.text?.getDateTimeCurrent()
        slider.maximumValue = Float(timeCurrentLabel.text!.getDateTimeCurrent())!
        slider.minimumValue = 1945
        yearBornLabel.text = String(Int(slider.value))
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

    //MARK: ACTIONS
    @IBAction func onSelectFemalePressed(_ sender: UIButton) {
        setupGenderView(maleView, femaleView, femaleButton, maleButton, .black, .lightGray, .femaleColor, .white)
        transition.animate(toView: femaleView, fromTriggerButton: maleButton)
    }
    
    @IBAction func onSelectMalePressed(_ sender: UIButton) {
        setupGenderView(femaleView, maleView, femaleButton, maleButton, .lightGray, .black, .white, .maleColor)
        transition.animate1(toView: maleView, fromTriggerButton: maleButton)
    }
    
    @IBAction func onNextPressed(_ sender: Any) {
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
    }
    
    @IBAction func onSliderPressed(_ sender: Any) {
        DispatchQueue.main.async {
            self.yearBornLabel.text = String(Int(self.slider.value))
        }
    }
    
    @IBAction func onDisplaySkipPressed(_ sender: Any) {
        let homeVC = HomeViewController.initWithDefaultNib()
        self.navigationController?.pushViewController(homeVC, animated: true)
//        let myContext = LAContext()
//        let myLocalizedReasonString = "Xin hãy nhập vân tay của bạn"
//        var authError: NSError?
//        if #available(iOS 8.0, macOS 10.12.1, *) {
//            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
//                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
//
//                    DispatchQueue.main.async {
//                        if success {
//                            // User authenticated successfully, take appropriate action
//                            let homeVC = HomeViewController.initWithDefaultNib()
//                            self.navigationController?.pushViewController(homeVC, animated: true)
//                        } else {
//                            // User did not authenticate successfully, look at error and take appropriate action
//                            print("failed")
//                        }
//                    }
//                }
//            } else {
//                // Could not evaluate policy; look at authError and present an appropriate message to user
//                print("Sorry!!.. Could not evaluate policy.")
//            }
//        } else {
//            // Fallback on earlier versions
//            print("Ooops!!.. This feature is not supported.")
//        }
    }
    
    //rotate viewcontroller
}

//textField keyboard show/hide
extension IntroViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: true)
    }
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}

