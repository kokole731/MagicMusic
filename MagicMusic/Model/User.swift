//
//  User.swift
//  MagicMusic
//
//  Created by Chandler on 2020/2/1.
//  Copyright © 2020 Chandler. All rights reserved.
//

import Foundation
import RealmSwift

class User:Object{
    @objc dynamic var id = 0
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    @objc dynamic var imageUrl = ""
    //听歌分数，累计用来确认用户的听歌等级
    @objc dynamic var score = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    //一对多关系，一个用户可以注册多个生活状态
    let states = List<Style>()
    
    //person1.dogs.append(dog1)
}

class UserTool: Object {
    
    private class func getDB() -> Realm {
        let realm = try! Realm()
        return realm
    }
    
    //初始化管理员用户
    public class func InitUser() {
        let realm = self.getDB()
        let user = User(value: [
        "id": 0,
        "username": "chandler",
        "password": "chandler",
        "imageUrl": ""])
        try! realm.write {
            realm.add(user)
        }
    }
    
    public class func allUser() -> Results<User> {
        let realm = self.getDB()
        return realm.objects(User.self)
    }

    public class func addUser(by user: User) {
        let realm = self.getDB()
        user.id = realm.objects(User.self).count
        try! realm.write {
            realm.add(user)
        }
    }
}
