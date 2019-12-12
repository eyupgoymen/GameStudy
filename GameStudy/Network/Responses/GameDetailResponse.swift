//
//  GameDetailResponse.swift
//  GameStudyProd
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

struct GameDetailResponse: Decodable {
    let id: Int
    let name: String
    let description: String
    let backgroundImage: URL?
    let redditUrl: String?
    let webSiteUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case backgroundImage = "background_image"
        case redditUrl = "reddit_url"
        case webSiteUrl = "website"
    }
}
