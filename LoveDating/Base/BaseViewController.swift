//
//  BaseViewController.swift
//  FramesLayout
//
//  Created by GEM on 4/5/19.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNav()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setupView() {
        
    }
    
    func setupNav() {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationItem.hidesBackButton = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //rotate viewcontroller
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
