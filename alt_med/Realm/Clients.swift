//
//  NoteRLM.swift
//  alt_med
//
//  Created by Oksana Gorbachenko on 3/2/18.
//  Copyright © 2018 Oksana Gorbachenko. All rights reserved.
//

import Foundation
import RealmSwift

class Clients : Object{
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var phone = ""
    @objc dynamic var age = 0
    @objc dynamic var genger = ""
    @objc dynamic var colour: String = ""
    //orders
    let orders = List<Orders>()
    
    @objc dynamic var dateCreated: Date?
    
    override static func primaryKey() -> String{
        return "id"

    }

    
}
