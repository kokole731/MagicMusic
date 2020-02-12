//
//  State.swift
//  MagicMusic
//
//  Created by Chandler on 2020/2/8.
//  Copyright © 2020 Chandler. All rights reserved.
//

import Foundation
import RealmSwift

//用户状态类
//studying---reading---exercising---gaming...

class State:Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
