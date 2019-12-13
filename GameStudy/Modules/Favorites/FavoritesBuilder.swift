//
//  FavoritesBuilder.swift
//  GameStudy
//
//  Created Eyup Kazım Göymen on 13.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

enum FavoritesBuilder {
    static func create() -> FavoritesViewController {
        let viewModel = FavoritesViewModel(persistanceService: PersistanceService())
        let viewController = FavoritesViewController(viewModel: viewModel)
        return viewController
    }
}
