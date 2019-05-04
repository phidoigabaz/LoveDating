//
//  StringExtension.swift
//  5dmax
//
//  Created by Admin on 3/10/17.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension String {

    func getDateWithFormat(_ format: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if let date = formatter.date(from: self) {
            return date
        } else {
            return Date(timeIntervalSince1970: 0)
        }
    }
    
    func getDateTimeCurrent() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy"
//        formatter.locale = Locale(identifier: "en_US_POSIX")
        let dateString = formatter.string(from: date)
        return dateString
    }

    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width,
                                           height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        return label.frame.height
    }
    
    func formatPhoneNumber(phone: String) -> [String] {
        let phoneOne = phone.components(separatedBy: "/")
        return phoneOne
    }
    
    func formaterRuntime(time: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .short
        let formattedString = formatter.string(from: TimeInterval(time))!
        return formattedString
        
    }
    
    func trim() -> String {
        let trimmedString = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString
    }
    
    func isVertifieldName(_ text: String) -> Bool {
        if text.count > 0, text.count < 16 {
            return true
        } else {
            return false
        }
    }
    
    func isVertifieldEmail() -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
}
