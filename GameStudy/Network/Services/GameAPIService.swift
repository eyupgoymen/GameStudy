//
//  GameAPIService.swift
//  GameStudyProd
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Moya

protocol GameAPIServiceProtocol {
    func fetchGames(pageNumber: Int, completion: @escaping GameListClosure)
    func searchGame(pageNumber: Int, keyword: String, completion: @escaping GameListClosure)
    func fetchDetail(gameId: Int, completion: @escaping GameDetailClosure)
}

final class GameAPIService: GameAPIServiceProtocol {
    
    private let apiProvider = MoyaProvider<GameAPI>()
    
    func fetchGames(pageNumber: Int, completion: @escaping (Result<[Game], NetworkError>) -> ()) {
        apiProvider.request(.fetchGames(pageNumber: pageNumber)) { (response) in
            switch response {
                case .success(let result):
                    do {
                        let gamesResponse = try JSONDecoder().decode(GameResponse.self, from: result.data)
                        completion(.success(gamesResponse.games))
                    } catch {
                        completion(.failure(NetworkError.parseError))
                    }
                
                case .failure(_):
                    completion(.failure(NetworkError.networkError))
            }
        }
    }
    
    func searchGame(pageNumber: Int, keyword: String, completion: @escaping GameListClosure) {
        apiProvider.request(.searchGames(pageNumber: pageNumber, keyword: keyword)) { (response) in
            switch response {
                case .success(let result):
                    do {
                        let gamesResponse = try JSONDecoder().decode(GameResponse.self, from: result.data)
                        completion(.success(gamesResponse.games))
                    } catch {
                        completion(.failure(NetworkError.parseError))
                    }
                
                case .failure(_):
                    completion(.failure(NetworkError.networkError))
            }
        }
    }
    
    func fetchDetail(gameId: Int, completion: @escaping GameDetailClosure) {
        apiProvider.request(.fetchDetail(gameId: gameId)) { (response) in
            switch response {
                case .success(let result):
                    do {
                        let gameDetailResponse = try JSONDecoder().decode(GameDetailResponse.self, from: result.data)
                        completion(.success(gameDetailResponse))
                    } catch {
                        completion(.failure(NetworkError.parseError))
                    }
                
                case .failure(_):
                    completion(.failure(NetworkError.networkError))
            }
        }
    }
}
