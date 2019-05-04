//
//  HomeViewController.swift
//  LoveDating
//
//  Created by Tạ Thành Đạt on 5/3/19.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var girlImageView: UIImageView!
    @IBOutlet weak var boyImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var isSelected: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setupView() {
        let value = NSNumber(value: UIInterfaceOrientation.landscapeRight.rawValue)
        UIDevice.current.setValue(value, forKey: "orientation")
        imagePicker.delegate = self
        girlImageView.setRadiusView(girlImageView.frame.height/2)
        boyImageView.setRadiusView(girlImageView.frame.height/2)
        let tapGirlGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(girlTapped))
        girlImageView.isUserInteractionEnabled = true
        girlImageView.addGestureRecognizer(tapGirlGestureRecognizer)
        let tapBoyGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(boyTapped))
        boyImageView.isUserInteractionEnabled = true
        boyImageView.addGestureRecognizer(tapBoyGestureRecognizer)
    }
    
    //MARK: METHODS
    
    @objc func girlTapped() {
        isSelected = true
        showAlertImagePickerController(imagePicker)
    }
    
    @objc func boyTapped() {
        isSelected =  false
        showAlertImagePickerController(imagePicker)
    }
    
    //rotate ViewController
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("finished picking image")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("imagePickerController called")
        
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        if isSelected {
            girlImageView.image = chosenImage
        } else {
            boyImageView.image = chosenImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //what happens when you cancel
        //which, in our case, is just to get rid of the photo picker which pops up
        dismiss(animated: true, completion: nil)
    }
}
