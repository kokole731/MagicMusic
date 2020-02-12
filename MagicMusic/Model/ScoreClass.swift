//
//  ScoreClass.swift
//  MagicMusic
//
//  Created by Chandler on 2020/2/8.
//  Copyright © 2020 Chandler. All rights reserved.
//

import Foundation
import RealmSwift

//用户听歌等级
//lever1---level2---

class ScoreClass: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
