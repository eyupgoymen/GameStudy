//
//  GameDetailViewModel.swift
//  GameStudy
//
//  Created Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

final class GameDetailViewModel: GameDetailViewModelProtocol {
    
    //Delegate methods and dependencies
    weak var delegate: GameDetailViewModelDelegate?
    var gameService: GameAPIServiceProtocol
    var persistanceService: PersistanceServiceProtocol
    
    //variables to update controller
    private(set) var game: Game
    var gameDetail: GameDetailResponse?
    var isInFavourites = false
    
    public required init(gameService: GameAPIServiceProtocol,
                         persistanceService: PersistanceServiceProtocol,
                         game: Game) {
        self.gameService = gameService
        self.persistanceService = persistanceService
        self.game = game
    }
    
    func fetchGameDetail() {
        notifyController(.loading(true))
        
        gameService.fetchDetail(gameId: game.id) { [weak self] (result) in
            guard let self = self else { return }
            self.notifyController(.loading(false))
            
            switch result {
                case .success(let gameDetail):
                    self.gameDetail = gameDetail
                    self.notifyController(.detailFetched(gameDetail))
                
                case .failure(let error):
                    self.notifyController(.showError(error))
            }
        }
    }
    
    func checkIfGameFavorited() {
        persistanceService.checkIfGameIsInFavourites(id: game.id) { [weak self] (isInFavourites) in
            guard let self = self else { return }
            self.isInFavourites = isInFavourites
            self.notifyController(.favouriteStatusChanged)
        }
    }
    
    func addFavorite() {
        guard let gameDetail = gameDetail else { return }
    
        persistanceService.addFavourite(gameDetail: gameDetail, game: game) { [weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                self.notifyController(.showError(error))
                return
            }
            self.isInFavourites = true
            self.notifyController(.favouriteStatusChanged)
        }
    }
    
    func removeFavorite() {
        persistanceService.deleteFavourite(gameId: game.id) { [weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                self.notifyController(.showError(error))
                return
             }
            self.isInFavourites = false
            self.notifyController(.favouriteStatusChanged)
        }
    }
    
    func notifyController(_ output: GameDetailViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
