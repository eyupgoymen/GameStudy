//
//  GameDetailModuleTest.swift
//  GameStudyTests
//
//  Created by Eyup Kazım Göymen on 13.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import XCTest
@testable import GameStudyDev

class GameDetailModuleTest: XCTestCase {
    
    private var view: MockView!
    private var viewModel: GameDetailViewModel!
    private var networkService: MockGameNetworkService!
    private var persistanceService: MockPersistanceService!
    
    override func setUp() {
        //Requires game
        let game = Game(id: 1, name: "Game 1", metacritic: nil, backgroundImageUrl: nil, genres: [Genre(name: "Genre1")])
        
        persistanceService = MockPersistanceService()
        networkService = MockGameNetworkService()
        viewModel = GameDetailViewModel(gameService: networkService, persistanceService: persistanceService, game: game)
        view = MockView()
        viewModel.delegate = view
    }
    
    override func tearDown() {
        view = nil
        viewModel = nil
        networkService = nil
        persistanceService = nil
    }
    
    func getDataFromBundle(fileName: String, ext: String) throws -> Data {
        let bundle = Bundle(for: GameStudyTests.NetworkTests.self)
        let url = try bundle.url(forResource: fileName, withExtension: ext).unwrap()
        return try Data(contentsOf: url)
    }
    
    func testGameDetailFetch() throws {
        //Get dummy games
        let data = try getDataFromBundle(fileName: "GameDetail", ext: "json")
        let gameDetail = try JSONDecoder().decode(GameDetailResponse.self, from: data)
        
        networkService.gameDetail = gameDetail
        viewModel.fetchGameDetail()
        
        //We have three states
        XCTAssertEqual(view.outputs.count, 3)
        
        guard case .loading(true) = try view.outputs.element(at: 0) else {
            XCTFail("Expected .loading(true), got \(try view.outputs.element(at: 0))")
            return
        }
        
        guard case .loading(false) = try view.outputs.element(at: 1) else {
            XCTFail("Expected .loading(false), got \(try view.outputs.element(at: 1))")
            return
        }
        
        guard case .detailFetched(_) = try view.outputs.element(at: 2) else {
            XCTFail("Expected .gamesFetched(games), got \(try view.outputs.element(at: 2))")
            return
        }
    }
    
    func testFavourites() throws {
        let data = try getDataFromBundle(fileName: "GameDetail", ext: "json")
        let gameDetail = try JSONDecoder().decode(GameDetailResponse.self, from: data)
        
        //Test adding fav
        viewModel.gameDetail = gameDetail
        viewModel.addFavorite()
        
        XCTAssertEqual(view.outputs.count, 0)
        XCTAssertEqual(persistanceService.favourites.count, 1)
        XCTAssertEqual(persistanceService.favourites.contains(gameDetail.id), true)
        view.reset()
        
        
        //Test removing fav
        viewModel.removeFavorite()
        XCTAssertEqual(persistanceService.favourites.count, 1)
        XCTAssertEqual(view.outputs.count, 1)
        
        guard case .favouriteStatusChanged = try view.outputs.element(at: 0) else {
             XCTFail("Expected .favouriteStatusChanged, got \(try view.outputs.element(at: 0))")
             return
        }
        view.reset()
        
        //Test if game is in favorites
        viewModel.checkIfGameFavorited()
        XCTAssertEqual(view.outputs.count, 1)
        XCTAssertEqual(viewModel.isInFavourites, false)
    }
}

private final class MockView: GameDetailViewModelDelegate {
    var outputs: [GameDetailViewModelOutput] = []
    var isNavigatedToSource = false
    
    func reset() {
        outputs.removeAll()
        isNavigatedToSource = false
    }
    
    func handleViewModelOutput(_ output: GameDetailViewModelOutput) {
        outputs.append(output)
    }
    
    func handleRouting(_ route: GameDetailRoute) {
        isNavigatedToSource = true
    }
}

private final class MockGameNetworkService: GameAPIServiceProtocol {
    var gameDetail: GameDetailResponse!
    
    func fetchGames(pageNumber: Int, completion: @escaping GameListClosure) { }
    func searchGame(pageNumber: Int, keyword: String, completion: @escaping GameListClosure) { }
    
    func fetchDetail(gameId: Int, completion: @escaping GameDetailClosure) {
        completion(.success(gameDetail))
    }
}

private final class MockPersistanceService: PersistanceServiceProtocol {
    
    var favourites: [Int] = []
    
    func checkIfGameIsInFavourites(id: Int, completion: @escaping BoolClosure) {
        let isContains = favourites.contains(id)
        completion(isContains)
    }
    
    func deleteFavourite(gameId: Int, completion: @escaping PersistanceErrorClosure) {
        if let index = favourites.index(of: gameId) {
            favourites.remove(at: index)
        }
        completion(nil)
    }
    
    func addFavourite(gameDetail: GameDetailResponse, game: Game, completion: @escaping PersistanceErrorClosure) {
        favourites.append(gameDetail.id)
    }
    
    func fetchFavourites(completion: @escaping FavouritesClosure) { }
}



