//
//  CoreDataManager.swift
//  Search
//
//  Created by Pavel on 10.07.22.
//

import Foundation
import CoreData

// MARK: - Core Data Manager
public class CoreDataManager {
    // MARK: Properties
    public let persistentContainer: NSPersistentContainer
    
    public static let shared = CoreDataManager()
    
    // MARK: Initializers
    private init() {
        persistentContainer = NSPersistentCloudKitContainer(name: "Movies")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data Store failed \(error)")
            }
        }
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    public func saveMovie(movie: MovieResultEntity.Movie) {
        let favoriteMovie = Movie(context: persistentContainer.viewContext)
        favoriteMovie.id = Int32(movie.id)
        favoriteMovie.title = movie.title 
        favoriteMovie.originalTitle = movie.originalTitle
        favoriteMovie.posterPath = movie.posterPath ?? ""
        favoriteMovie.releaseDate = movie.releaseDate
        favoriteMovie.overview = movie.overview
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to safe movie to database \(error)")
        }
    }
    
    public func deleteFavoriteMovie(movie: Movie) {
        persistentContainer.viewContext.delete(movie)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save context \(error)")
        }
    }
}
