//
//  DataManager.swift
//  5dmax
//
//  Created by Huy Nguyen on 3/4/17.
//  Copyright © 2017 Tung Duong Thanh. All rights reserved.
//

import UIKit

class DataManager: NSObject {

    class func objectForKey(_ key: String) -> Any? {
        let userDefault = UserDefaults.standard
        return userDefault.value(forKey: key)
    }

    class func boolForKey(_ key: String) -> Bool {
        let userDefault = UserDefaults.standard
        return userDefault.bool(forKey: key)
    }

    class func integerForKey(_ key: String) -> Int {
        let userDefault = UserDefaults.standard
        return userDefault.integer(forKey: key)
    }

    class func removeObject(forKey key: String) {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: key)
        userDefault.synchronize()
    }

    class func save(object: Any, forKey key: String) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(object, forKey: key)
        userDefault.synchronize()
    }

    class func save(boolValue: Bool, forKey key: String) {
        let userDefault = UserDefaults.standard
        userDefault.set(boolValue, forKey: key)
        userDefault.synchronize()
    }

    class func save(integerValue: Int, forKey key: String) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(integerValue, forKey: key)
        userDefault.synchronize()
    }

    class func save(floatValue: Float, forKey key: String) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(floatValue, forKey: key)
        userDefault.synchronize()
    }

    class func floatForKey(_ key: String) -> Float {
        let userDefault = UserDefaults.standard
        return userDefault.float(forKey: key)
    }
    
    class func getUserdefault() -> String {
        if let userNameDefault = DataManager.objectForKey(Constants.kUserDefault) {
            return userNameDefault as! String
        } else {
            return ""
        }
    }

    // MARK: 
    // MARK: User Profile
}
