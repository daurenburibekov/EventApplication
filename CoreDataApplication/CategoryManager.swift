//
//  CategoryManager.swift
//  CoreDataApplication
//
//  Created by Абылхайр on 23.02.2020.
//  Copyright © 2020 Dauren. All rights reserved.
//

import UIKit
import CoreData

class CategoryManager {


    func addItem(id: Int, name: String){
        let category = NSManagedObject(entity: getItemEntity(), insertInto: getManagedContext())
        category.setValue(id, forKey: "id")
        category.setValue(name, forKey: "name")
        do {
            try getManagedContext().save()
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
        
    }
    func deleteItem(id: Int){
        do{
            let fetchRequest = getFetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %i", id)
            let categories = try getManagedContext().fetch(fetchRequest)as! [Category]
            
            if categories.isEmpty {
                return
            }
            let category = categories[0]
            getManagedContext().delete(category)
            try getManagedContext().save()
        } catch let error as NSError{
            print("\(error.userInfo)")
        }
    }
    
    func getCategories() -> [Category]{
        do {
            return try getManagedContext().fetch(getFetchRequest())as! [Category]
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
        return []
    }
    
    func getCategory(id: Int) -> Category? {
        do {
            let fetchRequest = getFetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %i", id)
            let items = try getManagedContext().fetch(fetchRequest) as! [Category]
            
            if items.isEmpty {
                return nil
            }
            return items[0]
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
        return nil
    }
    
    func getCategory(name: String) -> Int?{
        do {
            let fetchRequest = getFetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name = %@", name)
            let items = try getManagedContext().fetch(fetchRequest) as! [Category]
            
            if items.isEmpty {
                return nil
            }
            return Int(items[0].id)
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
        return nil
    }
    
    private func getAppDelegate() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    private func getManagedContext() -> NSManagedObjectContext{
        return getAppDelegate().persistentContainer.viewContext
    }
    
    private func getItemEntity() -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Category", in: getManagedContext())!
    }
    
    private func getFetchRequest() -> NSFetchRequest<NSManagedObject> {
        return NSFetchRequest<NSManagedObject>(entityName: "Category")
    }
}
