//
//  Procedures.swift
//  alt_med
//
//  Created by Oksana Gorbachenko on 4/30/18.
//  Copyright © 2018 Oksana Gorbachenko. All rights reserved.
//

import Foundation
import RealmSwift

class Procedures : Object{
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title = ""
    @objc dynamic var type = ""
    @objc dynamic var timeSpending: Data?
    @objc dynamic var selfPrice = ""
    @objc dynamic var price = ""
    @objc dynamic var desc = ""
    @objc dynamic var dateCreated: Date?
    @objc dynamic var colour: String = ""
    
    
    override static func primaryKey() -> String{
        return "id"
        
    }
    
}
