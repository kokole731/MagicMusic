//
//  LibraryManager.swift
//  MagicMusic
//
//  Created by Chandler on 2020/2/9.
//  Copyright © 2020 Chandler. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class LibraryManager {
    private static let musicListUrl = "http://www.kokole.top/api/music"
    
}

//音乐库配置
/**
 mid
 歌名
 歌手
 专辑
 年份
 曲风
 专辑封面
 音频地址
 */
extension LibraryManager {
//    TODO:初始化数据库，只生成Like类型歌曲
    public class func initData(){
        var idList: [String] = []
        let url = self.musicListUrl
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
//                    let json = JSON(value)
//                    print(json)
                    let musicList = JSON(value)
                    for i in 0...musicList.count-1{
                        let title = musicList[i]["title"].string
                        let artist = musicList[i]["artist"].string
                        let album = musicList[i]["album"].string
                        let year = musicList[i]["year"].string
                        let style = musicList[i]["style"].string
                        let mid = musicList[i]["mid"].string
                        let image_url = musicList[i]["image_url"].string
                        let audio_url = musicList[i]["audio_url"].string
                        let item = Music(value: [
                            "title": title,
                            "artist": artist,
                            "album": album,
                            "year": year,
                            "style": style,
                            "mid": mid,
                            "imageUrl": image_url,
                            "audioUrl": audio_url
                        ])
                        //随机初始化歌单
                        let num = Int(arc4random()%100) + 1;
                        if num > 90{
                            item.collect = true
                            item.collectDate = Date()
                        }
                        idList.append(item.mid)
                        MusicRealmTool.addMusic(by: item)
                        print("添加喜爱歌曲:\(item.title)")
                    }
                    print("初始化歌单成功")
                }
            case false:
                print(response.result.error!)
            }
        }
        
    }
    
    func initByJsonData(jsonData: Data) {
       
    }

}
