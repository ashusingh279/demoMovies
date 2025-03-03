//
//  CoreDataManager.swift
//  demoApp
//
//  Created by Ashutosh Singh on 02/03/25.
//

import CoreData


 
// MARK: - Core Data Manager


class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieModel")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveMovie(id: Int, title: String, releaseDate: String?, overview: String, voteAverage: Double, imageData: Data?) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "MovieEntity", into: context)
        entity.setValue(id, forKey: "id")
        entity.setValue(title, forKey: "title")
        entity.setValue(releaseDate, forKey: "releaseDate")
        entity.setValue(overview, forKey: "overview")
        entity.setValue(voteAverage, forKey: "voteAverage")
        entity.setValue(imageData, forKey: "imageData")
        saveContext()
    }
    
    func fetchMovies() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching movies: \(error)")
            return []
        }
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}
