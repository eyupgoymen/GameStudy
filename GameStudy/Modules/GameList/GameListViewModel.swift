//
//  GameListViewModel.swift
//  GameStudy
//
//  Created Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

final class GameListViewModel: GameListViewModelProtocol {
    
    //Delegate methods and dependencies
    weak var delegate: GameListViewModelDelegate?
    private let gameService: GameAPIServiceProtocol
    
    //variables to update controller
    var games: [Game] = []
    var searchedGames: [Game] = []
    
    //Page tracking variables
    private var pageCountForListingGames   = 1
    private var pageCountForSearchingGames = 1
    
    //Set isSearchingGame considering searchKeyword that has been setted in search function.
    var searchKeyword: String = "" {
        didSet {
            isSearchingGame = searchKeyword.count > 0 ? true : false
        }
    }
    var isSearchingGame = false
    
    public required init(gameService: GameAPIServiceProtocol) {
        self.gameService = gameService
    }
    
    func fetchGames() {
        notifyController(.loading(true))
        
        gameService.fetchGames(pageNumber: pageCountForListingGames) { [weak self] (result) in
            guard let self = self else { return }
            self.notifyController(.loading(false))
            
            switch result {
                case .success(let newGames):
                    self.games += newGames
                    self.pageCountForListingGames += 1
                    self.notifyController(.gamesFetched)
                
                case .failure(let error):
                    self.notifyController(.showError(error))
            }
        }
    }
    
    func search(keyword: String) {
        self.searchKeyword = keyword.trimmingCharacters(in: .whitespaces).lowercased()
        guard searchKeyword.count >= 3 else { return }
        
        gameService.searchGame(pageNumber: pageCountForSearchingGames, keyword: searchKeyword) { [weak self](result) in
            guard let self = self else { return }
            
            switch result {
                case .success(let newSearchedGames):
                    self.searchedGames += newSearchedGames
                    self.pageCountForSearchingGames += 1
                    self.notifyController(.searchedGamesFetched)
                
                case .failure(let error):
                    self.notifyController(.showError(error))
            }
        }
    }
    
    func resetSearchResults() {
        searchedGames = []
        pageCountForSearchingGames = 1
    }
    
    func navigateToGameDetail(at index: Int) {
        delegate?.handleRouting(.GameDetail(game: searchedGames.count == 0 ? games[index] : searchedGames[index]))
    }
    
    func notifyController(_ output: GameListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
