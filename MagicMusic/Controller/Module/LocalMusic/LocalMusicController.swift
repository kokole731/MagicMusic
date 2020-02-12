//
//  LocalMusicController.swift
//  MagicMusic
//
//  Created by Chandler on 2020/1/11.
//  Copyright © 2020 Chandler. All rights reserved.
//

import UIKit
import RealmSwift
import ProgressHUD
import SwiftyJSON

class LocalMusicController: UITableViewController {

    //MARK:realm数据库对象
    let realm = try! Realm()
    //realm音乐对象列表
    var musicList: Results<Music>?
    //json数据用于初始化数据库
    var jsonData: Data?
    
//    //MARK:音乐对象信息
//    var title: String?
//    var artist: String?
//    var image: String?
//    var date: Date?
//    var style: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("显示收藏界面")
        //音乐列表初始化并按指定关键字排序
        musicList = realm.objects(Music.self).filter("collect == %@", true).sorted(byKeyPath: "title", ascending: true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    //视图出现时
    override func viewDidAppear(_ animated: Bool) {
        let isLogin = UserDefaults.standard.bool(forKey: "login")
        if !isLogin{
            self.performSegue(withIdentifier: "gotoLogin", sender: self)
        }
    }
    
    //MARK:刷新按钮
    @IBAction func updateBtn(_ sender: UIBarButtonItem) {
        tableView.reloadData()
        ProgressHUD.showSuccess("刷新成功")
    }
    
    // MARK: - Table view data source
    //共有一段
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    //一共有几行
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return musicList?.count ?? 1
    }

    //渲染每个单元格
    //TODO:处理图片资源
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath) as! LocalMusicCell
        let row = indexPath.row
        let mid = musicList?[row].mid
        //配置单元格歌名、歌手、专辑图片信息
        cell.songLabel.text = musicList?[row].title
        cell.singerLabel.text = musicList?[row].artist

//        cell.musicImage.downloadedFrom(link: (musicList?[row].imageUrl)!)
        cell.musicImage.image = UIImage(named: "album" + mid!)

        
        // Configure the cell...
        return cell
    }
    
    //设置单元格高度
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74.0
    }
    
    //选择某个单元格发生的事件
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //取消选择状态
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // 能否进入编辑状态
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 删除该歌曲
            deleteCollect(music: musicList![indexPath.row])
            ProgressHUD.showSuccess("删除成功")
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "musicPlayer" {
            //转至音乐播放界面
            let vc = segue.destination as! MusicPlayerController
            let cell = sender as! LocalMusicCell
            //通过sender找到当前的点击行
            let row = tableView.indexPath(for: cell)!.row
            vc.currentMusic = musicList![row]
            print(musicList![row].title)
        }
    }

}



extension LocalMusicController: UISearchBarDelegate{
    
    //MARK: 搜索框
    //搜索框被点击
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    //搜索框文本发生变化(即使变化)
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text!.isEmpty{
            musicList = realm.objects(Music.self)
            tableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }else{
            musicList = realm.objects(Music.self).filter("title contains %@", searchBar.text!).sorted(byKeyPath: "title", ascending: false)
            tableView.reloadData()
        }
        
    }
    
    //MARK:realm数据库操作
    
    //取消收藏
    func deleteCollect(music: Music){
        do {
            try realm.write {
                realm.objects(Music.self).filter("title = %@", music.title).first?.collect = false
                print("删除成功")
            }
        } catch  {
            print("error")
        }
    }
    
    func string2Date(_ string:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date!
    }
    
    func loadImg(from imageUrl: String) {
        let url = URL(string: imageUrl)
        let imgData = try! Data(contentsOf: url!)
        let imageView = UIImageView()
        imageView.image = UIImage(data: imgData)
    }
    
}

