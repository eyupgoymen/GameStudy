//
//  Environment.swift
//  GameStudyProd
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

struct EnvironmentManager {
    
    enum Target: String {
        case Prod, Dev, None
    }
    
    static var currentTarget: Target {
        #if Prod
        return Target.Prod
        #elseif Dev
        return Target.Dev
        #else
        return Target.None
        #endif
    }
}

