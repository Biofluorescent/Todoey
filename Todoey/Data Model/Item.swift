//
//  Item.swift
//  Todoey
//
//  Created by Tanner Quesenberry on 12/27/18.
//  Copyright © 2018 Tanner Quesenberry. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
