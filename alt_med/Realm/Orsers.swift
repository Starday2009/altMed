//
//  orsers.swift
//  alt_med
//
//  Created by Oksana Gorbachenko on 3/31/18.
//  Copyright © 2018 Oksana Gorbachenko. All rights reserved.
//

import Foundation
import RealmSwift

class Orders : Object{
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var done = false
    @objc dynamic var title = ""
    @objc dynamic var client = ""
    @objc dynamic var type = ""
    @objc dynamic var employee = ""
    @objc dynamic var visitTime: Date?
    @objc dynamic var price = ""
    @objc dynamic var dateCreated: Date?
    
    var parentCategory = LinkingObjects(fromType: Clients.self, property: "orders")
   
    
    override static func primaryKey() -> String{
        return "id"
        
    }

}
