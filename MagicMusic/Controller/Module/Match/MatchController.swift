//
//  MatchController.swift
//  MagicMusic
//
//  Created by Chandler on 2020/1/11.
//  Copyright © 2020 Chandler. All rights reserved.
//

import UIKit
import RealmSwift
import ProgressHUD
import StreamingKit

class MatchController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var searchText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldInit();
        // Do any additional setup after loading the view.
    }
    
    //在曲库中检索是否存在该歌曲
    @IBAction func matchBtn(_ sender: Any) {
        searchText.resignFirstResponder()
        let music = realm.objects(Music.self).filter("title = %@", searchText.text!).first
        if music != nil{
            self.performSegue(withIdentifier: "matchResult", sender: self)
        }else{
            ProgressHUD.showError("没有该歌曲！")
        }
    }
    //测试
    @IBAction func add(_ sender: Any) {
        let audioPlayer = STKAudioPlayer()
        audioPlayer.play("http://www.kokole.top/music/audio/2.mp3")
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "matchResult"{
            let vc = segue.destination as! MatchDetailController
            let music = realm.objects(Music.self).filter("title = %@", searchText.text!).first
            if let music = music{
                vc.matchedMusic = music
            }
            searchText.text = ""
        }
    }
    
}

extension MatchController: UITextFieldDelegate{
    
    func textFieldInit() {
        searchText.clearButtonMode = .whileEditing
        searchText.returnKeyType = UIReturnKeyType.done
    }
    
    //键盘消失
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText.resignFirstResponder()
        return true
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchText.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchText.resignFirstResponder()
    }
    
    
    
}
