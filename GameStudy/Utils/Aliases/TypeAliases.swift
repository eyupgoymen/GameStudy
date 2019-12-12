//
//  TypeAliases.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

//Belongs to Persistance
typealias BoolClosure = (Bool) -> ()
typealias PersistanceErrorClosure = (PersistanceError?) -> ()
typealias FavouritesClosure = (Result<[Favourites], PersistanceError>) -> ()

//Belongs to Network
typealias GameListClosure   = (Result<[Game], NetworkError>) -> ()
typealias GameDetailClosure = (Result<GameDetailResponse, NetworkError>) -> ()
