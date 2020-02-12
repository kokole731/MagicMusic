//
//  LoginController.swift
//  MagicMusic
//
//  Created by Chandler on 2020/2/1.
//  Copyright © 2020 Chandler. All rights reserved.
//  登陆、注册界面 （根据用户是否处于登陆状态，若用户已登陆，则不弹出）

import UIKit
import RealmSwift
import ProgressHUD

class LoginController: UIViewController {

    var userList: Results<User>?
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var usePasswordText: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("展示登陆界面")
        userNameText.becomeFirstResponder()
        userList = UserTool.allUser()
        imageInit()
        // Do any additional setup after loading the view.
    }
 
    //登陆判断
    @IBAction func loginPressed(_ sender: Any) {
//        self.performSegue(withIdentifier: "login", sender: self)
        let loginRst = judgeLogin()
        if loginRst{
            print("登录成功！")
        }else {
            print("登录失败！")
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        //控制用户的用户名和密码必须规范
        judgeRegist()
        
    }
    //logo初始化
    func imageInit(){
        logoImage.layer.cornerRadius = logoImage.frame.width / 2
        loginBtn.layer.cornerRadius = 10
        registerBtn.layer.cornerRadius = 10
    }
    
    func judgeLogin() -> Bool {
        let rst = judge()
        switch rst {
        case 0:
            ProgressHUD.showError("该用户不存在")
            userNameText.text = ""
            usePasswordText.text = ""
        case 1:
            ProgressHUD.showError("密码不正确")
            usePasswordText.text = ""
        case 2:
            print("登陆成功")
            UserDefaults.standard.set(true, forKey: "login")
            self.performSegue(withIdentifier: "login", sender: self)
        default:
            self.performSegue(withIdentifier: "login", sender: self)
        }
        return rst >= 2
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginController: UITextFieldDelegate{
    //判读用户名和密码是否正确
    func judge() -> Int {
        let username = userNameText.text!
        let password = usePasswordText.text!
        let hasUser = userList?.filter("username == %@", username).count
        if hasUser == 0{
            return 0
        }else{
            let correctPsd = userList!.filter("username == %@", username).first!.password
            if correctPsd != password{
                return 1
            }else{
                return 2
            }
        }
    }
    //判断注册信息是否合法
    func judgeRegist() {
        
        let username = userNameText.text!
        let password = usePasswordText.text!
        var flag = true
        var msg = ""
        if username.count < 6 || password.count < 6{
            msg = "用户名或密码长度不够"
            flag = false
        }else if username.contains(" ") || password.contains(" "){
            msg = "用户名或密码包含非法字符"
            flag = false
        }
//        else if userList?.filter("username == %@", username) != nil{
//            msg = "该用户名已被注册"
//            flag = false
//        }
        else{
            flag = true
        }
        if flag{
//            try! realm.write {
//                realm.add(User(value: ["username": "\(username)", "password": "\(password)"]))
//            }
            let user = User()
            user.username = username
            user.password = password
            UserTool.addUser(by: user)
            userList = UserTool.allUser()
            ProgressHUD.showSuccess("注册成功", interaction: true)
        }else{
            ProgressHUD.showError(msg)
            userNameText.text = ""
            usePasswordText.text = ""
        }
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameText.resignFirstResponder()
        usePasswordText.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let rst = judgeLogin()
        return rst
    }
    
    

}
