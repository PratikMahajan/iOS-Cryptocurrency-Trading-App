//
//  ProfileVC.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/2/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import UIKit
import GRDB
import AWSCore
import AWSS3

class ProfileVC: UIViewController {

    @IBOutlet weak var signoutBtn: UIButton!
    @IBOutlet weak var addBalBtn: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    var username: String = ""
    var fname: String = ""
    var lname: String = ""
    var email: String = ""
    @IBOutlet weak var nameData: UILabel!
    @IBOutlet weak var emailData: UILabel!
    
    
    
    @IBAction func seeDocumentAction(_ sender: Any) {
        
        
    }
    
    @IBAction func signOutAction(_ sender: Any) {
        
        deleteAll()
        performSegue(withIdentifier: "signout", sender: nil)
        
    }
    
    
    
    func getData(){
        do{
            try dbQueue.read { db in
                let user = try User.fetchAll(db)
                username = user[0].username
            }
        }
        catch{
            print("Error in reading data")
        }
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        loginCheck()
        
        addBalBtn.layer.cornerRadius = 15
        addBalBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        signoutBtn.layer.cornerRadius = 15
        signoutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 78.5
        profileImage.clipsToBounds = true
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        let url = URL(string: "https://ui-avatars.com/api/?size=512&background=0D8ABC&color=fff&name="+username)
        if let data = try? Data(contentsOf: url!)
        {
            let img: UIImage = UIImage(data: data)!
            profileImage.image = img
        }
        
        userName?.text = username
        nameData?.text = fname+" "+lname
        emailData?.text = email
        
        navBar.barTintColor = UIColor(patternImage: UIImage(named: "background.png")!)
        navBar.isTranslucent = true;
        
        // Do any additional setup after loading the view.
    }

    
    func loginCheck(){
        // prepare json data
        let json: [String: Any] = ["username": username]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: "http://127.0.0.1:5000/getAccount")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200{
                    print ("No username Found")
                    return
                }
            }
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                self.fname = responseJSON["fname"] as! String
                self.lname = responseJSON["lname"] as! String
                self.email = responseJSON["email"] as! String
                
            }
        }
        task.resume()
    }
    
    
    func deleteAll(){

        do{
            try dbQueue.write { db in
                try db.execute(
                    "delete from user")
                print ("deleted")
            }}
        catch{
            print ("not deleted")
        }
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
