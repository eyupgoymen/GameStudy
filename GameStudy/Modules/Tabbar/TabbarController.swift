//
//  TabbarController.swift
//  GameStudyProd
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

final class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
        initBars()
    }
    
    private func setAppearance() {
        tabBar.tintColor = UIColor(hexString: "1064BC")
        tabBar.isTranslucent = false
    }
    
    private func initBars() {
        let gameListVC = GameListBuilder.create()
        gameListVC.tabBarItem.image = UIImage(named: "tabbar_games")
        gameListVC.tabBarItem.title = "Games"
        
        let favoritesVC = FavoritesBuilder.create()
        favoritesVC.tabBarItem.image = UIImage(named: "tabbar_favorite")
        favoritesVC.tabBarItem.title = "Favorites"
                
        viewControllers = [UINavigationController(rootViewController: gameListVC), UINavigationController(rootViewController: favoritesVC)]
    }
}
