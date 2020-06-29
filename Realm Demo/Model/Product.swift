//
//  Product.swift
//  Realm Demo
//
//  Created by Ercan on 29.06.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import RealmSwift

class Product : Object {
    @objc dynamic var productName : String = ""
    @objc dynamic var price : Int = 0
}
