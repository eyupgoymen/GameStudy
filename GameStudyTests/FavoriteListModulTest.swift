//
//  FavoriteListModulTest.swift
//  GameStudyTests
//
//  Created by Eyup Kazım Göymen on 13.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import XCTest
@testable import GameStudyDev

class FavoriteListModulTest: XCTestCase {
    
    private var view: MockView!
    private var viewModel: FavoritesViewModel!
    private var persistanceService: MockPersistanceService!
    
    override func setUp() {
        persistanceService = MockPersistanceService()
        viewModel = FavoritesViewModel(persistanceService: persistanceService)
        view = MockView()
        viewModel.delegate = view
    }
    
    override func tearDown() {
        view = nil
        viewModel = nil
        persistanceService = nil
    }
    
    func getDataFromBundle(fileName: String, ext: String) throws -> Data {
        let bundle = Bundle(for: GameStudyTests.NetworkTests.self)
        let url = try bundle.url(forResource: fileName, withExtension: ext).unwrap()
        return try Data(contentsOf: url)
    }
    
    func testGameFetch() throws {
        //Get dummy games
        let data = try getDataFromBundle(fileName: "Games", ext: "json")
        let gameResponse = try JSONDecoder().decode(GameResponse.self, from: data)
        
        persistanceService.games = gameResponse.games
        viewModel.fetchGames()
        
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
         
        guard case .gamesFetched = try view.outputs.element(at: 2) else {
             XCTFail("Expected .gamesFetched, got \(try view.outputs.element(at: 2))")
             return
         }
    }
}

private final class MockView: FavoritesViewModelDelegate {
    var outputs: [FavoritesViewModelOutput] = []
    
    func reset() {
        outputs.removeAll()
    }
    
    func handleViewModelOutput(_ output: FavoritesViewModelOutput) {
        outputs.append(output)
    }
}

private final class MockPersistanceService: PersistanceServiceProtocol {
    
    var games: [Game] = []
    
    func deleteFavourite(gameId: Int, completion: @escaping PersistanceErrorClosure) {
        completion(nil)
    }
    
    func fetchFavourites(completion: @escaping FavouritesClosure) {
        completion(.success(games))
    }
    
    func checkIfGameIsInFavourites(id: Int, completion: @escaping BoolClosure) { }
    func addFavourite(gameDetail: GameDetailResponse, game: Game, completion: @escaping PersistanceErrorClosure) {}
}
