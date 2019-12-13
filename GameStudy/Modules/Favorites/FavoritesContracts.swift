//
//  FavoritesContracts.swift
//  GameStudy
//
//  Created Eyup Kazım Göymen on 13.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

protocol FavoritesViewModelProtocol {
    var delegate: FavoritesViewModelDelegate? { get set }
    var games: [Game] { get set }
    
    func fetchGames()
    func removeFavorite(at index: Int)
}

protocol FavoritesViewModelDelegate: class {
    func handleViewModelOutput(_ output: FavoritesViewModelOutput)
}

enum FavoritesViewModelOutput {
    case loading(Bool)
    case showError(Error)
    case gamesFetched
    case removedFavorite(index: Int)
}
