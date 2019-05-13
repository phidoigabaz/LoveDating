//
//  UIImageViewExtension.swift
//  PamZ
//
//  Created by admin on 11/13/18.
//  Copyright © 2018 admin. All rights reserved.
//
import UIKit
import Kingfisher

fileprivate var activityIndicatorAssociationKey: UInt8 = 0

@IBDesignable
class UIImageViewExtension: UIImageView {
    
    private var _cornerRadius: CGFloat = 0.0
    private var _shadowRadius: CGFloat = 0.0
    private var _opacity: Float = 0.0
    private var _shadowOffset = CGSize(width: 2, height: 2)
    private var _shadowColor: UIColor?
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set (newValue) {
            _cornerRadius = newValue
            layer.cornerRadius = _cornerRadius
        } get {
            return _cornerRadius
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        set (newValue) {
            _shadowRadius = newValue
            layer.shadowRadius = _shadowRadius
        } get {
            return _shadowRadius
        }
    }
    
    @IBInspectable
    var opacity: Float {
        set (newValue) {
            _opacity = newValue
            layer.shadowOpacity = _opacity
        } get {
            return _opacity
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor {
        set (newValue) {
            _shadowColor = newValue
            layer.shadowColor = _shadowColor?.cgColor
        } get {
            return _shadowColor!
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        set (newValue) {
            _shadowOffset = newValue
            layer.shadowOffset = newValue
        } get {
            return _shadowOffset
        }
    }
}

extension UIImageView {
    var activityIndicator: UIActivityIndicatorView! {
        get {
            return objc_getAssociatedObject(self, &activityIndicatorAssociationKey) as? UIActivityIndicatorView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &activityIndicatorAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    // load image with  and add place holder during loading
    func loadImageFromUrl(_ url: String, andPlaceHolder placeHolder:UIImage, andCach cache:Bool){
        self.image = placeHolder
        if cache {
            AsyncImageDownloader.default.load(imageView: self,url: url)
        }
        else
        {
            AsyncImageDownloader.default.loadImageFor(imageView: self,url: url)
        }
    }
    
    // load image with  and add activity indicator  during loading
    func loadImageFromUrl(_ url: String, withActivityIndicator style: UIActivityIndicatorView.Style, andCach cache:Bool){
        self.showActivityIndicatorWith(style: style)
        if cache {
            AsyncImageDownloader.default.load(imageView: self,url: url)
        }
        else
        {
            AsyncImageDownloader.default.loadImageFor(imageView: self,url: url)
        }
    }
    
    /// add activityIndicator to the center of image view
    func showActivityIndicatorWith(style: UIActivityIndicatorView.Style) {
        if (self.activityIndicator == nil) {
            self.activityIndicator = UIActivityIndicatorView(style: style)
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.frame = CGRect(x:  0, y: 0, width: 30, height: 30);
            self.activityIndicator.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2);
            self.activityIndicator.autoresizingMask = [.flexibleLeftMargin , .flexibleRightMargin , .flexibleTopMargin , .flexibleBottomMargin]
            self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            self.activityIndicator.isUserInteractionEnabled = false
            OperationQueue.main.addOperation({ () -> Void in
                self.addSubview(self.activityIndicator)
                self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                self.addConstraint(NSLayoutConstraint(item: self.activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
                self.addConstraint(NSLayoutConstraint(item: self.activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
                self.activityIndicator.startAnimating()
            })
        }
    }
    
    
    /// stop activityIndicator
    func hideActivityIndicator() {
        guard self.activityIndicator != nil else {
            return
        }
        OperationQueue.main.addOperation({ () -> Void in
            self.activityIndicator.stopAnimating()
        })
    }
}
