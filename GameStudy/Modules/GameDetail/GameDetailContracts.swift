//
//  GameDetailContracts.swift
//  GameStudy
//
//  Created Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

protocol GameDetailViewModelProtocol {
    var delegate: GameDetailViewModelDelegate? { get set }
    var gameDetail: GameDetailResponse? { get set }
    
    func fetchGameDetail()
    func checkIfGameFavorited()
    func addFavorite()
    func removeFavorite()
    func didSelectCell(at index: Int)
}

protocol GameDetailViewModelDelegate: class {
    func handleViewModelOutput(_ output: GameDetailViewModelOutput)
    func handleRouting(_ route: GameDetailRoute)
}

enum GameDetailViewModelOutput {
    case loading(Bool)
    case showError(Error)
    case detailFetched(GameDetailResponse)
    case favouriteStatusChanged
}

enum GameDetailRoute {
    case reddit(String)
    case website(String)
}

//Cell sections
@objc enum DetailCellSections: Int {
    case description = 0
    case reddit
    case website
    
    init?(section: Int){
        self.init(rawValue: section)
    }
}
