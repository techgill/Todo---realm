//
//  Items.swift
//  TodoApp
//
//  Created by Gill Hardeep on 08/04/20.
//  Copyright © 2020 Gill Hardeep. All rights reserved.
//

import Foundation
import RealmSwift

class Items: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: CategoryClass.self, property: "items")
}

