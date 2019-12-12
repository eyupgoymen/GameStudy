//
//  NetworkError.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case parseError
    case networkError
    case endOfPages
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .parseError:
                return NSLocalizedString("Application based error occured.", comment: "Error")
            
            case .networkError:
                return NSLocalizedString("Problem has occured in network.", comment: "Error")
            
            case .endOfPages:
                return NSLocalizedString("End of pages", comment: "Error")
        }
    }
}
