//
//  MusicPlayerController.swift
//  MagicMusic
//
//  Created by Chandler on 2020/1/16.
//  Copyright © 2020 Chandler. All rights reserved.
//

import UIKit
import AVFoundation
import ProgressHUD
import StreamingKit

class MusicPlayerController: UIViewController {
    
    //播放器
//    var playerItem: AVPlayerItem?
//    var player: AVPlayer?
    //当前播放的音乐
    var currentMusic: Music?

    var song: String?
    var singer: String?
    
    //专辑图片
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var albumImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let albumName = "album" + currentMusic!.mid
        backgroundImage.image = UIImage(named: albumName)
        albumImage.image = UIImage(named: albumName)
        //隐藏导航栏
//        self.navigationController?.navigationBar.isHidden = true
//        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    //控制导航栏的显示与消失
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func nextBtn(_ sender: Any) {
//        audioPlayer.stop()
    }
    //播放歌曲
    @IBAction func playBtn(_ sender: UIButton) {
        AudioManager.play(music: currentMusic!)
    }
    //停止播放
    @IBAction func stopBtn(_ sender: Any) {
        AudioManager.pause()
    }
    
    //返回歌单
    @IBAction func backBtn(_ sender: UIButton) {
//        self.navigationController?.navigationBar.isHidden = false
//        self.tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
        
    //初始化播放器
//    func initAVPlayer() {
//
//        let musicName = currentMusic!.artist + " - " + currentMusic!.title
//        print("正在播放的音乐为：\(musicName)")
//        let path = Bundle.main.path(forResource: musicName, ofType: "mp3")
//        if path != nil{
//            let url = URL(fileURLWithPath: path!)
//            playerItem = AVPlayerItem(url: url)
//            player = AVPlayer(playerItem: playerItem!)
//        }else{
//            print("路径错误:\(musicName)")
//        }
//    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "playerDetail"{
            let vc = segue.destination as! PlayerDetailController
            vc.currentMusic = currentMusic!
        }
    }
    

}
