//
//  GamePresentation.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 13.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import CoreData

extension Game {
    
    init(favorite: Favourites) {
        if let imageURL = favorite.backgroundImage {
            self.backgroundImageUrl = URL(string: imageURL)
        }
        else {
            self.backgroundImageUrl = nil
        }
        
        //Genres stored via comma
        if let genres = favorite.genres {
            self.genres = genres.components(separatedBy: ", ").map{ Genre(name: $0) }
        }
        else {
            self.genres = []
        }
                
        //In nil case for local metacritic, its -1
        self.metacritic = favorite.metacritic == Int32(-1) ? nil : Int(favorite.metacritic)
        
        self.id = Int(favorite.id)
        self.name = favorite.name ?? ""
    }
}
