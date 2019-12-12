//
//  GameDetailBuilder.swift
//  GameStudy
//
//  Created Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

enum GameDetailBuilder {
    static func create(game: Game) -> GameDetailViewController {
        let viewModel = GameDetailViewModel(gameService: GameAPIService(), persistanceService: PersistanceService(), game: game)
        let viewController = GameDetailViewController(viewModel: viewModel)
        return viewController
    }
}
