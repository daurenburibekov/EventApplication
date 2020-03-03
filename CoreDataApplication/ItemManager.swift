//
//  ItemManager.swift
//  CoreDataApplication
//
//  Created by Абылхайр on 19.02.2020.
//  Copyright © 2020 Dauren. All rights reserved.
//

import UIKit
import CoreData
class ItemManager {

    func addItem(id: Int, name: String, desc: String, place: String, date: Date, categoryId: Int){
        let item = NSManagedObject(entity: getItemEntity(), insertInto: getManagedContext())
        item.setValue(id, forKey: "id")
        item.setValue(name, forKey: "name")
        item.setValue(desc, forKey: "desc")
        item.setValue(place, forKey: "place")
        item.setValue(date, forKey: "date")
        item.setValue(categoryId, forKey: "categoryId")
        do {
            try getManagedContext().save()
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
        
    }
    
    func getItems() -> [Event]{
        do {
            return try getManagedContext().fetch(getFetchRequest())as! [Event]
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
        return []
    }
    func getFavItemst(fav: Bool) -> [Event]{
        do {
            let fetchRequest = getFetchRequest()
            fetchRequest.predicate = NSPredicate(format: "fav = %i", fav)
            let events = try getManagedContext().fetch(fetchRequest) as! [Event]
            return events
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
        return []
    }
    
    func getItem(id: Int) -> Event? {
        do {
            let fetchRequest = getFetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %i", id)
            let events = try getManagedContext().fetch(fetchRequest) as! [Event]
            
            if events.isEmpty {
                return nil
            }
            return events[0]
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
        return nil
    }
    
    func changeFav(id: Int) {
        do {
            let fetchRequest = getFetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %i", id)
            let items = try getManagedContext().fetch(fetchRequest) as! [Event]
            
            if items.isEmpty {
                return
            }
            let item = items[0]
            if(item.fav != true) {
                item.setValue(true, forKeyPath: "fav")
            } else {
                item.setValue(false, forKeyPath: "fav")
            }
            try getManagedContext().save()
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
    }
    
    func getLastId() -> Int? {
        do {
            if getItems().isEmpty {
                return 1
            }
            let fetchRequest = getFetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %i", getItems()[getItems().count - 1].id)
            let lastId =  try getManagedContext().fetch(fetchRequest) as! [Event]
            return Int(lastId[0].id)
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
        return nil
    }
    
    func editItem(id: Int, name: String, desc: String, place: String, date: Date, categoryId: Int){
        do{
            let fetchRequest = getFetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %i", id)
            let items = try getManagedContext().fetch(fetchRequest) as! [Event]

            if items.isEmpty {
                return
            }
            let item = items[0]
            item.setValue(name, forKeyPath: "name")
            item.setValue(desc, forKeyPath: "desc")
            item.setValue(place, forKey: "place")
            item.setValue(place, forKeyPath: "date")
            item.setValue(place, forKeyPath: "categoryId")

            try getManagedContext().save()
        } catch let error as NSError{
            print("\(error.userInfo)")
        }
    }
    func deleteItem(id: Int){
        do{
            let fetchRequest = getFetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %i", id)
            let items = try getManagedContext().fetch(fetchRequest)as! [Event]

            if items.isEmpty {
                return
            }
            let item = items[0]
            getManagedContext().delete(item)
            try getManagedContext().save()
        } catch let error as NSError{
            print("\(error.userInfo)")
        }
    }
    private func getAppDelegate() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    private func getManagedContext() -> NSManagedObjectContext{
        return getAppDelegate().persistentContainer.viewContext
    }
    
    private func getItemEntity() -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Event", in: getManagedContext())!
    }
    
    private func getFetchRequest() -> NSFetchRequest<NSManagedObject> {
        return NSFetchRequest<NSManagedObject>(entityName: "Event")
    }

}
