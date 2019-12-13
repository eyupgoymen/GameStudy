//
//  FavoritePresentation.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 13.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import CoreData

extension Favourites {
    convenience init(game: Game) {
        self.init()
        id = Int32(game.id)
        
        //backgroundImage
        if let backgroundImageURL = game.backgroundImageUrl?.absoluteString {
            backgroundImage = backgroundImageURL
        }
        else {
            backgroundImage = nil
        }
        
        //Metacritic
        if let safeMetacritic = game.metacritic {
            metacritic = Int32(safeMetacritic)
        }
        else {
            metacritic = -1
        }
        
        genres = game.genres.map { $0.name }.joined(separator: ", ")
        name = game.name
    }
}

