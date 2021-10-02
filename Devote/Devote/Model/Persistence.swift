//
//  Persistence.swift
//  Devote
//
//  Created by Scott Clampet on 10/1/21.
//

import CoreData

struct PersistenceController {
    //MARK: Singleton Instance
    static let shared = PersistenceController()
    //MARK: Persistant Container
    let container: NSPersistentContainer

    //MARK: Init and load the persistant store
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Devote")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    //MARK: Preview (Sets up test data). In Memory store (as opposed to disk) allows us to clear out test data with every new instance of the app.
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        for i in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = "Sample task \(i)"
            newItem.complete = false
            newItem.id = UUID()
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()
}
