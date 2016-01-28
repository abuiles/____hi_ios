//
//  Location.swift
//  GeoShadows
//
//  Created by Adolfo on 1/28/16.
//  Copyright © 2016 Adolfo Builes. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var title: String = "point"
    dynamic var subtitle: String = "subtitle"
    
//    override static func ignoredProperties() -> [String] {
//        return ["title", "subtitle"]
//    }
}
