//
//  Style.swift
//  MagicMusic
//
//  Created by Chandler on 2020/2/8.
//  Copyright © 2020 Chandler. All rights reserved.
//

import Foundation
import RealmSwift


//音乐类型类
//mandopop---country---

class Style: Object{
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    //声明主键后，该对象可以被查询
    //带有主键的对象加入到数据库中，该对象的主键不可修改
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //重写 Object.ignoredProperties() 可以防止 Realm 存储数据模型的某个属性
    override static func ignoredProperties() -> [String] {
        return ["tempID"]
    }

    
}
