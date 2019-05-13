//
//  HomeViewController.swift
//  LoveDating
//
//  Created by Tạ Thành Đạt on 5/3/19.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import FaveButton

class HomeViewController: BaseViewController {

    @IBOutlet weak var girlImageView: UIImageView!
    @IBOutlet weak var boyImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var loveButton: LoveButton!
    
    let imagePicker = UIImagePickerController()
    var isSelected: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setupView() {
//        let value = NSNumber(value: UIInterfaceOrientation.landscapeRight.rawValue)
//        UIDevice.current.setValue(value, forKey: "orientation")
        imagePicker.delegate = self
        girlImageView.setRadiusView(girlImageView.frame.height/2)
        boyImageView.setRadiusView(girlImageView.frame.height/2)
        let tapGirlGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(girlTapped))
        girlImageView.isUserInteractionEnabled = true
        girlImageView.addGestureRecognizer(tapGirlGestureRecognizer)
        let tapBoyGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(boyTapped))
        boyImageView.isUserInteractionEnabled = true
        boyImageView.addGestureRecognizer(tapBoyGestureRecognizer)
        //girlImageView.image = UIImage.gifImageWithName(name: "boyGif")
        //boyImageView.image = UIImage.gifImageWithName(name: "girlGif")
        SaveCoreData.shared.getUserData()
    }
    
    override func setupNav() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.menuBarItem(target: self, btnAction: #selector(menuBarItem))
    }
    
    @objc func menuBarItem() {
        let menuVC = MenuViewController.initWithDefaultNib()
        navigationController?.pushViewController(menuVC, animated: true)
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
    
    @IBAction func onAnimatePressed(_ sender: LoveButton) {
        //sender.isLoved = !sender.isLoved!
    }
    
    //rotate ViewController
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageView = UIImageView(frame: self.loveButton.frame)
        imageView.image = UIImage(named: "heart_icon")
        self.view.addSubview(imageView)
        //loveButton.isLoved = true
        UIView.animate(withDuration: 2, animations: { () -> Void in
            imageView.transform = CGAffineTransform(scaleX: 3,y: 3)
            imageView.alpha = 0
        }) { (completed) -> Void in
            //self.loveButton.isLoved = false
            imageView.removeFromSuperview()
        }
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
