//
//  BaseNavigationController.swift
//  HandShake
//
//  Created by hnc on 11/14/17.
//  Copyright © 2017 vietpd-iOS. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.delegate = self
    }
    
    func setUp() {
        self.navigationBar.isHidden = true
        self.navigationBar.isOpaque = true
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.backgroundColor = .clear
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                       NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15.0)]
        self.navigationBar.titleTextAttributes = (titleDict as! [NSAttributedString.Key : Any])
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
//    override var shouldAutorotate: Bool {
//        return  true
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    class func initWithDefaultStyle(rootViewController: UIViewController!) -> BaseNavigationController {
        let nav = BaseNavigationController(rootViewController: rootViewController)
        nav.setUp()
        return nav
    }
    
}

extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController, animated: Bool) {
        if let currentVC = self.topViewController {
            let itemBack = UIBarButtonItem(title: "", style: .done, target: currentVC, action: nil)
            currentVC.navigationItem.backBarButtonItem = itemBack
        }
    }
}

extension UINavigationController {

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if visibleViewController?.supportedInterfaceOrientations == .landscape {
            return .landscape
        }
        return .portrait
    }

    override open var shouldAutorotate: Bool {
        return true
    }

    static func navigate(to vc: UIViewController) {
        if let topVc = UINavigationController.topController() {
            topVc.navigationController?.pushViewController(vc, animated: true)
        }
    }

    static func topController() -> UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        if let navigation = topController as? UINavigationController {
            topController = navigation.visibleViewController
        }
        return topController
    }
}
