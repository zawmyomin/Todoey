//
//  Item.swift
//  Todoey
//
//  Created by Zaw Myo Min on 3/15/18.
//  Copyright © 2018 zawmyomin. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
    var title : String = ""
    var done: Bool = false
    
}
