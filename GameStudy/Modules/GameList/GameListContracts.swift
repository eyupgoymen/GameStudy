//
//  GameListContracts.swift
//  GameStudy
//
//  Created Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

protocol GameListViewModelProtocol {
    var delegate: GameListViewModelDelegate? { get set }
    var games: [Game] { get set }
    var searchedGames: [Game] { get set }
    var isSearchingGame: Bool { get set }
    
    func fetchGames()
    func search(keyword: String)
    func navigateToGameDetail(at index: Int)
    func resetSearchResults()
}

protocol GameListViewModelDelegate: class {
    func handleViewModelOutput(_ output: GameListViewModelOutput)
    func handleRouting(_ route: GameListRoute)
}

enum GameListViewModelOutput {
    case loading(Bool)
    case showError(NetworkError)
    case gamesFetched
    case searchedGamesFetched
}

enum GameListRoute {
    case GameDetail(game: Game)
}
