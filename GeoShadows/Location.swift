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

    // MARK: Attributes

    dynamic var id: String        = NSUUID().UUIDString
    dynamic var date              = NSDate()
    dynamic var latitude: Double  = 0.0
    dynamic var longitude: Double = 0.0

    override static func primaryKey() -> String? {
        return "id"
    }
}
