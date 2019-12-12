//
//  GameAPI.swift
//  GameStudyProd
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Moya

enum GameAPI {
    case fetchGames(pageNumber: Int)
    case searchGames(pageNumber: Int, keyword: String)
    case fetchDetail(gameId: Int)
}

extension GameAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.rawg.io/api/games")!
    }
    
    var path: String {
        switch self {
            case .fetchDetail(let gameId):
                return "/\(gameId)"
            default:
                return ""
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
            case .fetchDetail(_):
                return .requestPlain
            
            case .fetchGames(let pageNumber):
                return .requestParameters(parameters:
                    ["page_size" : 10, "page" : pageNumber], encoding: URLEncoding.default)
            
            case .searchGames(let pageNumber, let keyword):
                return .requestParameters(parameters:
                    ["page_size" : 10, "page" : pageNumber, "search" : keyword], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
