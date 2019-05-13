//
//  CoreDataHelper.swift
//  LoveDating
//
//  Created by Tạ Thành Đạt on 5/13/19.
//  Copyright © 2019 dattt. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataHelper {
    
    private init() {}
    static func getData(_ entityName: String) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
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
}
