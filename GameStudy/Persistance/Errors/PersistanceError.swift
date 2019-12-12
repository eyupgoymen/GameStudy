//
//  PersistanceError.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

enum PersistanceError: Error {
    case couldntSaveFavourite
    case couldntRemoveFavourite
    case couldntFetchFavourites
    case couldntFindFavourite
}

extension PersistanceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .couldntSaveFavourite:
                return NSLocalizedString("Couldn't add favourite", comment: "Error")
            
            case .couldntRemoveFavourite:
                return NSLocalizedString("Couldn't remove favourite", comment: "Error")
            
            case .couldntFetchFavourites:
                return NSLocalizedString("Couldn't get favourites", comment: "Error")
            
            case .couldntFindFavourite:
                return NSLocalizedString("Not in favourite list", comment: "Error")
        }
    }
}
