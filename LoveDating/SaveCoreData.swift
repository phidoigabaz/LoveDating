//
//  SaveCoreData.swift
//  LoveDating
//
//  Created by Tạ Thành Đạt on 5/7/19.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import CoreData

enum SaveStatus {
    case success
    case failed
}

struct Users {
    var name: String?
    var gender: String?
    var phone: String?
    var yearBorn: String?
    var timelove: String?
    
    init() {
    }
    
    init(_ name: String?,_ gender: String?,_ phone: String?,_ yearBorn: String?,_ timelove: String?) {
        self.name = name
        self.gender = gender
        self.phone = phone
        self.yearBorn = yearBorn
        self.timelove = timelove
    }
}

class SaveCoreData: NSObject {
    static let shared = SaveCoreData()
    var users = Users()
   
    func saveUserData(_ name: String,_ gender: String,_ phone: String,_ timelove: String,_ yearBorn: String) {
        let context = Constants.appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto:  context)
        newUser.setValue(name, forKey: "name")
        newUser.setValue(gender, forKey: "gender")
        newUser.setValue(phone, forKey: "phone")
        newUser.setValue(yearBorn, forKey: "yearborn")
        newUser.setValue(timelove, forKey: "timelove")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func isDataUser() -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        let context = Constants.appDelegate.persistentContainer.viewContext
        request.returnsObjectsAsFaults = false
        var results = [NSManagedObject]()
        do {
            let result = try context.fetch(request)
            results = result as! [NSManagedObject]
        } catch {
            print("Failed")
        }
        return results
    }
    
    func getUserData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        let context = Constants.appDelegate.persistentContainer.viewContext
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                users.name = data.value(forKey: "name") as? String
                users.gender = data.value(forKey: "gender") as? String
                users.phone = data.value(forKey: "phone") as? String
                users.yearBorn = data.value(forKey: "yearborn") as? String
                users.timelove = data.value(forKey: "timelove") as? String
            }
        } catch {
            print("Failed")
        }
    }
}
