//
//  Category.swift
//  Todoey
//
//  Created by Tanner Quesenberry on 12/27/18.
//  Copyright © 2018 Tanner Quesenberry. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
