//
//  GameListModuleTest.swift
//  GameStudyTests
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import XCTest
@testable import GameStudyDev

class GameListModuleTest: XCTestCase {

    private var view: MockView!
    private var viewModel: GameListViewModel!
    private var service: MockGameService!
    
    override func setUp() {
        service = MockGameService()
        viewModel = GameListViewModel(gameService: service)
        view = MockView()
        viewModel.delegate = view
    }

    override func tearDown() {
        view = nil
        viewModel = nil
        service = nil
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
        
        service.games = gameResponse.games
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
            XCTFail("Expected .gamesFetched(games), got \(try view.outputs.element(at: 2))")
            return
        }
    }
    
    func testNavigation() throws {
        //Get dummy games first
        let data = try getDataFromBundle(fileName: "Games", ext: "json")
        let gameResponse = try JSONDecoder().decode(GameResponse.self, from: data)
        
        service.games = gameResponse.games
        viewModel.fetchGames()
        
        //Check if its navigating
        viewModel.navigateToGameDetail(at: 0)
        XCTAssertEqual(view.isNavigatedToDetail, true)
    }
    
    func testSearchGame() throws {
        //Get dummy games
        let data = try getDataFromBundle(fileName: "Games", ext: "json")
        let gameResponse = try JSONDecoder().decode(GameResponse.self, from: data)
        
        service.games = gameResponse.games
        viewModel.search(keyword: "keyword")
        
        //We have three states
        XCTAssertEqual(view.outputs.count, 1)
        
        guard case .searchedGamesFetched = try view.outputs.element(at: 0) else {
            XCTFail("Expected .gamesFetched(games), got \(try view.outputs.element(at: 0))")
            return
        }
    }
}

private final class MockView: GameListViewModelDelegate {
    var outputs: [GameListViewModelOutput] = []
    var isNavigatedToDetail = false
    
    func reset() {
        outputs.removeAll()
        isNavigatedToDetail = false
    }
    
    func handleViewModelOutput(_ output: GameListViewModelOutput) {
        outputs.append(output)
    }
    
    func handleRouting(_ route: GameListRoute) {
        isNavigatedToDetail = true
    }
}

class MockGameService: GameAPIServiceProtocol {    
    var games: [Game] = []
    var searchedGames: [Game] = []
    
    func fetchGames(pageNumber: Int, completion: @escaping GameListClosure) {
        completion(.success(games))
    }
    
    func searchGame(pageNumber: Int, keyword: String, completion: @escaping GameListClosure) {
        completion(.success(searchedGames))
    }
    
    func fetchDetail(gameId: Int, completion: @escaping GameDetailClosure) { }
}
