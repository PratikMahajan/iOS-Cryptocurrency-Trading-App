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
    var role: String = ""
    var un : String = ""
    var ps : String = ""
    var k : Bool = true
    
    @IBOutlet weak var signin: UIButton!
    
    @IBOutlet weak var signup: UIButton!
    
    @IBOutlet weak var forgotPass: UIButton!
    
    
    @IBAction func signInAction(_ sender: Any) {
        un = usernameTxt.text!
        ps = passwordTxt.text!
        
        loginCheck ()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 1 to desired number of seconds
            if self.k{
                self.getInfo()
//                print (self.role)
                if self.role == "user"{
                    //                print ("performing segue")
                    self.performSegue(withIdentifier: "user", sender: nil)
                }
                if self.role == "admin"{
                    //                print ("performing segue")
                    self.performSegue(withIdentifier: "verification", sender: nil)
                }
            }
            else{
                let alert = UIAlertController(title: "ERROR", message: "Wrong Information", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
//        getInfo()
//        print (self.role)
//        if self.role == "user"{
//            print ("performing segue")
//            performSegue(withIdentifier: "user", sender: nil)
//        }

        
    }
    
    
    func getInfo(){
        do{
            try dbQueue.read { db in
                let user = try User.fetchAll(db)
                self.role = user[0].role
//                print (user)
            }
        }
        catch{
            print("Error in reading data")
        }
    }
    
    

    func loginCheck(){
        // prepare json data
        let json: [String: Any] = ["username": usernameTxt.text as! String,
                                   "password": passwordTxt.text as! String]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: "http://127.0.0.1:5000/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200{
                    self.k = false
                    return
                }
            }
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                let transfer = responseJSON["role"] as! String
                let usr = responseJSON["userid"] as! String
                let verify = responseJSON["verify"] as! Int
                let balance = responseJSON["balance"] as! Double
//                print (balance)
                self.role = transfer
                self.k = true
                self.insertTable(rol: transfer, uid: usr, verify: verify, balance: balance)
                
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
    @IBAction func signUpAction(_ sender: Any) {
        
        
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        
        
    }
    
    func insertTable(rol: String, uid: String, verify: Int, balance: Double){
        do{
            try dbQueue.write { db in
                try db.execute(
                    "insert into user values (?,?,?,?,?,?)", arguments: [uid, un, ps, rol, verify,balance])
//                print ("inserted")
            }}
        catch{
            print ("error in insert")
        }
        
    }
    
    
    func testInsert(){
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
        do{
            try dbQueue.write { db in
                try db.execute(
                    "delete from user")
            print ("deleted")
            }}
        catch{
            print ("not deleted")
        }
//
//
//
//
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide nav bar hairline
        signin.layer.cornerRadius = 15
        signin.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        signup.layer.cornerRadius = 15
        signup.titleLabel?.font = UIFont.systemFont(ofSize: 14)
      
        forgotPass.layer.cornerRadius = 15
        forgotPass.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        
        usernameTxt.borderStyle = UITextBorderStyle.roundedRect
        passwordTxt.borderStyle = UITextBorderStyle.roundedRect
        // Do any additional setup after loading the view.
        
        
        
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        
        
        
        
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
