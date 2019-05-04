//
//  UIViewControllerExtension.swift
//  mPI
//
//  Created by Macintosh on 6/7/18.
//  Copyright © 2018 Macintosh. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class func initWithDefaultNib() -> Self {
        let bundle = Bundle.main
        let fileManege = FileManager.default
        let nibName = String(describing: self)
        
        if let pathStoryboard = bundle.path(forResource: nibName, ofType: "storyboardc") {
            if fileManege.fileExists(atPath: pathStoryboard) {
                return initWithDefautlStoryboard()
            }
        }
        
        if let pathXib = bundle.path(forResource: nibName, ofType: "nib") {
            if fileManege.fileExists(atPath: pathXib) {
                return initWithNibTemplate()
            }
        }
        return initWithNibTemplate()
    }
    
    class func initWithNibTemplate<T>() -> T {
        var nibName = String(describing: self)
        if Constants.isIpad {
            if let pathXib = Bundle.main.path(forResource: "\(nibName)_\(Constants.iPad)", ofType: "nib") {
                if FileManager.default.fileExists(atPath: pathXib) {
                    nibName = "\(nibName)_\(Constants.iPad)"
                }
            }
        }
        let viewcontroller = self.init(nibName: nibName, bundle: Bundle.main)
        return viewcontroller as! T
    }
    
//    private class func initWithNibTemplate<T>() -> T {
//        let nibName = String(describing: self)
//        let viewcontroller = self.init(nibName: nibName, bundle: Bundle.main)
//        return viewcontroller as! T
//    }
    
    class func initWithDefautlStoryboard() -> Self {
        let className = String(describing: self)
        return instantiateFromStoryboardHelper(storyboardName: className, storyboardId: className)
    }
    
    private class func instantiateFromStoryboardHelper<T>(storyboardName: String, storyboardId: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: storyboardId) as! T
        return controller
    }
    
    func showAlert(title: String?, message: String?, completeHanle : ((() -> Swift.Void)?)) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        
        let dismissAction = UIAlertAction(title: "Settings", style: UIAlertAction.Style.default) { (_) in
            if completeHanle != nil {
                completeHanle!()
            }
        }
        alertView.addAction(cancelAction)
        alertView.addAction(dismissAction)
        
        let viewController = UIApplication.shared.windows.first?.rootViewController
        DispatchQueue.main.async {
            viewController!.present(alertView, animated: true, completion: nil)
        }
    }
    
    func showAlertImagePickerController(_ imagePicker: UIImagePickerController) {
        let optionMenu = UIAlertController(title: nil, message: "Where would you like the image from?", preferredStyle: UIAlertController.Style.actionSheet)
        
        let photoLibraryOption = UIAlertAction(title: "Photo Library", style: UIAlertAction.Style.default, handler: { (alert: UIAlertAction!) -> Void in
            print("from library")
            //shows the photo library
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            imagePicker.modalPresentationStyle = .popover
            self.present(imagePicker, animated: true, completion: nil)
        })
        let cameraOption = UIAlertAction(title: "Take a photo", style: UIAlertAction.Style.default, handler: { (alert: UIAlertAction!) -> Void in
            print("take a photo")
            //shows the camera
           imagePicker.allowsEditing = true
           imagePicker.sourceType = .camera
           imagePicker.modalPresentationStyle = .popover
           self.present(imagePicker, animated: true, completion: nil)
            
        })
        let cancelOption = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
            self.dismiss(animated: true, completion: nil)
        })
        
        //Adding the actions to the action sheet. Camera will only show up as an option if the camera is available in the first place.
        optionMenu.addAction(photoLibraryOption)
        optionMenu.addAction(cancelOption)
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) == true {
            optionMenu.addAction(cameraOption)} else {
            print ("I don't have a camera.")
        }
        self.present(optionMenu, animated: true, completion: nil)
    }
}
