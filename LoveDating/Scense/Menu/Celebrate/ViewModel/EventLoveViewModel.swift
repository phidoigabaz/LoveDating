//
//  EventLoveViewModel.swift
//  LoveDating
//
//  Created by Tạ Thành Đạt on 5/13/19.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import CoreData

let entityName = "Celebrate"

class EventLoveViewModel {
    let itemsModel: [ItemModel] = []
    var results = CoreDataHelper.getData(entityName)
    
    var itemsCount: Int {
        return itemsModel.count
    }
    
    func getItemsCount() -> Int {
        let itemsCount = CoreDataHelper.getData(entityName)
        return itemsCount.count
    }
    
    func inserAndSaveItem(_ id: String,_ title: String, _ photo: String) {
        let context = Constants.appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto:  context)
        newUser.setValue(id, forKey: "id")
        newUser.setValue(title , forKey: "title")
        newUser.setValue(photo, forKey: "photo")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func deleteItem() {
        
    }
}
