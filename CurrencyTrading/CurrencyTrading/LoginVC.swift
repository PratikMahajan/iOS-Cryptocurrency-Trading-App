//
//  LoginVC.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/2/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import UIKit
import GRDB

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    @IBAction func signInAction(_ sender: Any) {
        
        
        
        
        
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        
        
    }
    
//    func testInsert(){
//
//        do{
//            try dbQueue.write { db  in
//                var player = User(user_id: "test1", username: "test1", password: "test1", role: "user")
//                try player.insert(db)
//            }
//        }
//        catch{
//            print ("Error in insert")
//        }
////        do{
////            try dbQueue.write { db in
////                try db.execute(
////                    "Drop table user")
////            print ("deleted")
////            }}
////        catch{
////            print ("not deleted")
////        }
//
//
//
//
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
