//
//  Music.swift
//  MagicMusic
//
//  Created by Chandler on 2020/1/11.
//  Copyright © 2020 Chandler. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

enum MusicStyle: String {
    case country = "country"    //乡村
    case light = "light"      //轻音乐
    case rap = "rap"        //嘻哈
    case jazz = "jazz"       //爵士
    case classic  = "classic"   //古典
    case folk = "folk"      //民歌
    case pop = "pop"       //流行
    case metal = "metal"     //金属
    static let allValues = ["country", "light", "rap", "jazz", "classic", "folk", "pop", "metal"]
}

class Music: Object{
    
    @objc dynamic var mid = ""
    @objc dynamic var title = ""
    @objc dynamic var artist = ""
    @objc dynamic var style = ""
    @objc dynamic var album = ""
    @objc dynamic var year = ""
    //服务器上的图片、音频资源
    @objc dynamic var imageUrl = ""
    @objc dynamic var audioUrl = ""
    //是否收藏以及收藏时间
    @objc dynamic var collect = false
    @objc dynamic var collectDate = Date()
    //TODO: 用户此时听歌的状态(返回状态id)
    @objc dynamic var state = 0
    
    override class func primaryKey() -> String? {
        return "mid"
    }
}

class MusicRealmTool: Object{
    
    private class func getDB() -> Realm {
//        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
//        let dbPath = docPath.appending("/defaultDB.realm")
        /// 传入路径会自动创建数据库
//        let defaultRealm = try! Realm(fileURL: URL.init(string: dbPath)!)
        let defaultRealm = try! Realm()
        return defaultRealm
    }
}

extension MusicRealmTool {
    public class func addMusic(by music: Music) {
        let realm = self.getDB()
        try! realm.write {
            realm.add(music)
        }
    }
}

//class Music: Object{
//    @objc dynamic var id = 0
//    @objc dynamic var title = ""
//    @objc dynamic var artist = ""
//    @objc dynamic var album = ""
//    @objc dynamic var style = ""
//    //服务器上的图片、音频资源
//    @objc dynamic var imageUrl = ""
//    @objc dynamic var audioUrl = ""
//    //是否收藏以及收藏时间
//    @objc dynamic var collect = false
//    @objc dynamic var collectDate = Date()
//    //TODO: 用户此时听歌的状态
//    @objc dynamic var state = 0
//
//    override class func primaryKey() -> String? {
//        return "id"
//    }
//
//}


//class Music {
//    var song = ""
//    var singer = ""
//    var image = ""
//    init(song: String, singer: String, image: String) {
//        self.song = song
//        self.singer = singer
//        self.image = "music/m" + image
//    }
//}
