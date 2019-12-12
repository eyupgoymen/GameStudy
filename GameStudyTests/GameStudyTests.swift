//
//  GameStudyTests.swift
//  GameStudyTests
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import XCTest
@testable import GameStudyDev

class GameStudyTests: XCTestCase {

    func testGameParse() throws {
        let data = try getDataFromBundle(fileName: "Games", ext: "json")
        let gameResponse = try JSONDecoder().decode(GameResponse.self, from: data)

        XCTAssertEqual(gameResponse.games.count, 10)
        XCTAssertEqual(gameResponse.games.first?.id, 3498)
        XCTAssertEqual(gameResponse.games[4].id, 12020)
        XCTAssertEqual(gameResponse.games[3].name, "The Elder Scrolls V: Skyrim")
        XCTAssertEqual(gameResponse.games[1].metacritic, 95)
    }
    
    func testGameDetailParse() throws {
        let data = try getDataFromBundle(fileName: "GameDetail", ext: "json")
        let gameDetailResponse = try JSONDecoder().decode(GameDetailResponse.self, from: data)
        
        XCTAssertEqual(gameDetailResponse.name, "Grand Theft Auto V")
        XCTAssertEqual(gameDetailResponse.id, 3498)
        XCTAssertEqual(gameDetailResponse.redditUrl, URL(string: "https://www.reddit.com/r/GrandTheftAutoV/d"))
    }

    func getDataFromBundle(fileName: String, ext: String) throws -> Data {
        let bundle = Bundle(for: GameStudyTests.self)
        let url = try bundle.url(forResource: fileName, withExtension: ext).unwrap()
        return try Data(contentsOf: url)
    }
}
