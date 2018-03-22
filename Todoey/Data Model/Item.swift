//
//  Item.swift
//  Todoey
//
//  Created by Zaw Myo Min on 3/22/18.
//  Copyright © 2018 zawmyomin. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
   @objc dynamic var title : String = ""
   @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
