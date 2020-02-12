//
//  MatchDetailController.swift
//  MagicMusic
//
//  Created by Chandler on 2020/1/14.
//  Copyright © 2020 Chandler. All rights reserved.
//

import UIKit
import RealmSwift
import ProgressHUD


class MatchDetailController: UITableViewController {

    let realm = try! Realm()
    
    @IBOutlet weak var collectBtnOutlet: UIButton!
    //MARK:歌曲信息
    var matchedMusic:Music?
    @IBOutlet weak var songNameText: UILabel!
    @IBOutlet weak var singerText: UILabel!
    @IBOutlet weak var styleText: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //格式初始化
        formatInit()
        infoInit()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //MARK: 信息初始化
    func formatInit() {
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine;
//        self.tableView.separatorColor = UIColor.clear;
        songNameText.lineBreakMode = NSLineBreakMode.byWordWrapping
        songNameText.numberOfLines = 0
        
        collectBtnOutlet.layer.cornerRadius = 10
    }
    
    func infoInit() {
        if let music = matchedMusic{
            songNameText.text = music.title
            singerText.text = music.artist
            styleText.text = music.style
//            albumImage.image = UIImage(named: music.imageUrl)
            print(music.imageUrl)
            albumImage.downloadedFrom(link: music.imageUrl)
        }else{
            songNameText.text = "未知"
            singerText.text = "未知"
            styleText.text = "未知"
            albumImage.image = UIImage(named: "1024")
        }
        
    }
    
    //添加个人收藏
    @IBAction func addBtn(_ sender: UIButton) {
        if let matchedMusic = matchedMusic{
            let songName = matchedMusic.title
            if realm.objects(Music.self).filter("title = %@ and collect == %@", songName, true).first != nil{
                print("该歌曲已经收藏")
                ProgressHUD.showError("该歌曲已经收藏")
            }else{
                addFavorate(music: matchedMusic)
                ProgressHUD.showSuccess("收藏成功")
                //不用委托了
//                MatchDelegate.addMusicItem(music: matchedMusic)
                print("收藏成功")
            }
        }else{
            print("曲库中无该歌曲")
            ProgressHUD.showError("曲库中无该歌曲")
        }
//        navigationController?.popViewController(animated: true)
    }
        

    @IBAction func confirmBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    //添加至本地歌单
    func addFavorate(music: Music){
        do {
            try realm.write {
                realm.objects(Music.self).filter("title = %@", music.title).first?.collect = true
            }
        } catch  {
            print(error)
        }
        
    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

