//
//  PersistanceManager.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation
import CoreData

protocol PersistanceServiceProtocol {
    func fetchFavourites(completion: @escaping FavouritesClosure)
    func checkIfGameIsInFavourites(id: Int, completion: @escaping BoolClosure)
    func deleteFavourite(gameId: Int, completion: @escaping PersistanceErrorClosure)
    func addFavourite(gameDetail: GameDetailResponse, game: Game,completion:  @escaping PersistanceErrorClosure)
}

final class PersistanceService: PersistanceServiceProtocol {
    
    lazy var context = persistentContainer.viewContext
    
    lazy private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameStudy")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
        
    ///Fetch entire data via type
    func fetchFavourites(completion: @escaping FavouritesClosure) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.favourites.rawValue)
        
        do {
            guard let favourites = try context.fetch(fetchRequest) as? [Favourites] else {
                completion(.failure(.couldntFetchFavourites))
                return
            }
            let games = favourites.map{ Game(favorite: $0)}
            completion(.success(games))
        }
        catch {
            return completion(.failure(.couldntFetchFavourites))
        }
    }
    
    /// Check if game is in favourites, if so returns true
    func checkIfGameIsInFavourites(id: Int, completion: @escaping BoolClosure) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.favourites.rawValue)
        fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))
        
        do {
            let fetchedResults = try context.fetch(fetchRequest) as! [Favourites]
            return fetchedResults.first == nil ? completion(false) : completion(true)
        }
        catch {
            completion(false)
        }
    }
    
    /// Removes from favourites
    func deleteFavourite(gameId: Int, completion: @escaping PersistanceErrorClosure) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.favourites.rawValue)
        fetchRequest.predicate = NSPredicate(format: "id = %@", String(gameId))
        let request = NSBatchDeleteRequest(fetchRequest: fetchRequest )
        
        do {
            try context.execute(request)
            try context.save()
            completion(nil)
        } catch {
            completion(PersistanceError.couldntRemoveFavourite)
        }
    }
    
    /// Add favourite via game and gameDetail
    func addFavourite(gameDetail: GameDetailResponse, game: Game,completion:  @escaping PersistanceErrorClosure) {
        let newFavouriteEntity = Favourites(context: self.context)
        newFavouriteEntity.name = gameDetail.name
        newFavouriteEntity.backgroundImage = gameDetail.backgroundImage?.absoluteString
        newFavouriteEntity.id = Int32(gameDetail.id)
        newFavouriteEntity.genres = game.genres.map { $0.name }.joined(separator: ", ")
        
        // If metracritic is nil, set it as -1. Bad code!
        if let metacritic = game.metacritic {
            newFavouriteEntity.metacritic = Int32(metacritic)
        }
        else {
            newFavouriteEntity.metacritic = -1
        }
        
        
       
        do {
            try context.save()
            completion(nil)
        } catch {
            completion(PersistanceError.couldntSaveFavourite)
        }
    }
}

