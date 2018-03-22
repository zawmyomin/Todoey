//
//  Category.swift
//  Todoey
//
//  Created by Zaw Myo Min on 3/22/18.
//  Copyright © 2018 zawmyomin. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
