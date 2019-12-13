//
//  FavoritesViewModel.swift
//  GameStudy
//
//  Created Eyup Kazım Göymen on 13.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

final class FavoritesViewModel: FavoritesViewModelProtocol {

    //Delegate methods and dependencies
    weak var delegate: FavoritesViewModelDelegate?
    var persistanceService: PersistanceServiceProtocol
    
    //variables to update controller
    var games: [Game] = []
    
    public required init(persistanceService: PersistanceServiceProtocol) {
        self.persistanceService = persistanceService
    }
        
    func fetchGames() {
        notifyController(.loading(true))
        
        persistanceService.fetchFavourites { [weak self] (result) in
            guard let self = self else { return }
            self.notifyController(.loading(false))
            
            switch result {
                case .success(let games):
                    self.games = games 
                    self.notifyController(.gamesFetched)
                
                case .failure(let error):
                    self.notifyController(.showError(error))
            }
        }
    }
    
    func removeFavorite(at index: Int) {
        persistanceService.deleteFavourite(gameId: games[index].id) { [weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                self.notifyController(.showError(error))
                return
            }
            
            self.games.removeAll(where: {$0.id == self.games[index].id})
            self.notifyController(.removedFavorite(index: index))
        }
    }
    
    func notifyController(_ output: FavoritesViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
