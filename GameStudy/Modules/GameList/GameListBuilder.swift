//
//  GameListBuilder.swift
//  GameStudy
//
//  Created Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

enum GameListBuilder {
    static func create() -> GameListViewController {
        let viewModel = GameListViewModel(gameService: GameAPIService())
        let viewController = GameListViewController(viewModel: viewModel)
        return viewController
    }
}
