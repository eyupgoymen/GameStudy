//
//  Favourites+CoreDataProperties.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//
//

import Foundation
import CoreData


extension Favourites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourites> {
        return NSFetchRequest<Favourites>(entityName: "Favourites")
    }

    @NSManaged public var id: Int32
    @NSManaged public var backgroundImage: String?
    @NSManaged public var metacritic: Int32
    @NSManaged public var name: String?
    @NSManaged public var genres: String?

}
