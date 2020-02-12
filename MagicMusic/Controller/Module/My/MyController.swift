//
//  MyController.swift
//  MagicMusic
//
//  Created by Chandler on 2020/1/15.
//  Copyright © 2020 Chandler. All rights reserved.
//

import UIKit

class MyController: UITableViewController {
    @IBOutlet weak var signOutBtn: UIButton!
    
    @IBOutlet weak var headImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //头像初始化(圆形)
        imageInit()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func imageInit() {
        let headLenth = headImage.frame.width
        headImage.layer.cornerRadius = headLenth / 2
        signOutBtn.layer.cornerRadius = 10
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //选中后取消选中该单元格
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func signOutPressed(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "login")
    }
}
