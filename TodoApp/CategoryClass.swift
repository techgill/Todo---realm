//
//  CategoryClass.swift
//  TodoApp
//
//  Created by Gill Hardeep on 08/04/20.
//  Copyright © 2020 Gill Hardeep. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryClass: Object {
    @objc dynamic var name: String = ""
    let items = List<Items>()
}
