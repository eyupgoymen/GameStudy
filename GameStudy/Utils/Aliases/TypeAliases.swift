//
//  TypeAliases.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

//Belongs to Persistance
typealias BoolClosure = (Bool) -> ()
typealias PersistanceErrorClosure = (PersistanceError?) -> ()
typealias FavouritesClosure = (Swift.Result<[Game], PersistanceError>) -> ()

//Belongs to Network
typealias GameListClosure   = (Swift.Result<[Game], NetworkError>) -> ()
typealias GameDetailClosure = (Swift.Result<GameDetailResponse, NetworkError>) -> ()

//Table view
typealias TableViewProtocols = UITableViewDelegate & UITableViewDataSource
