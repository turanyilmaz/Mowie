//
//  DatabaseManager.swift
//  Mowie
//
//  Created by Turan Yilmaz on 27.08.2021.
//

import CoreData

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private init() {}
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Mowie")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: CRUD Methods
    
    func save(item: AddToList.DataModel, to list: ListType) {
        let context = persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Item", in: context) else {
            return
        }
        
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        managedObject.setValue(item.id, forKey: "id")
        managedObject.setValue(item.posterPath, forKey: "posterPath")
        managedObject.setValue(item.itemName, forKey: "name")
        managedObject.setValue(item.year, forKey: "year")
        
        managedObject.setValue(item.rate, forKey: "rate")
        managedObject.setValue(item.type.rawValue, forKey: "type")
        managedObject.setValue(list.rawValue, forKey: "list")

        saveContext()
    }
    
    func getItems(for list: ListType, and itemType: ItemType) -> [AddToList.DataModel]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        
        let predicate1 = NSPredicate(format: "list = %@", list.rawValue)
        let predicate2 = NSPredicate(format: "type = %@", itemType.rawValue)
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        
        fetchRequest.predicate = compoundPredicate
        
        do {
            let managedObjects = try context.fetch(fetchRequest) as? [NSManagedObject]
            
            return managedObjects?.map({ managedObject in
                AddToList.DataModel(id: managedObject.value(forKey: "id") as? Int,
                                    posterPath: managedObject.value(forKey: "posterPath") as? String,
                                    itemName: managedObject.value(forKey: "name") as? String,
                                    year: managedObject.value(forKey: "year") as? String,
                                    rate: managedObject.value(forKey: "rate") as? Double,
                                    type: ItemType(rawValue: (managedObject.value(forKey: "type") as? String).stringValue)!,
                                    selectedList: ListType(rawValue: (managedObject.value(forKey: "list") as? String).stringValue)!)
            })
            
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func deleteItem(by itemId: Int) {
        let context = persistentContainer.viewContext
        if let managedObject = getItem(by: itemId) {
            context.delete(managedObject)
            saveContext()
        }
    }
    
    func moveItem(to list: ListType, by itemId: Int) {
        if let managedObject = getItem(by: itemId) {
            managedObject.setValue(list.rawValue, forKey: "list")
            saveContext()
        }
    }
    
    func getItem(by itemId: Int) -> NSManagedObject? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        
        fetchRequest.predicate = NSPredicate(format: "id = %d", itemId)
        
        do {
            
            return try context.fetch(fetchRequest).first as? NSManagedObject
           
            
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func getSelectedList(for itemId: Int?) -> ListType? {
        
        guard let itemId = itemId else {
            return nil
        }
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        
        fetchRequest.predicate = NSPredicate(format: "id = %d", itemId)
        
        do {
            guard let managedObject = try context.fetch(fetchRequest).first as? NSManagedObject else {
                return nil
            }
            
            guard let listString = managedObject.value(forKey: "list") as? String else {
                return nil
            }
            
            return ListType(rawValue: listString)
            
        } catch {
            print(error)
        }
        
        return nil
    }
}
