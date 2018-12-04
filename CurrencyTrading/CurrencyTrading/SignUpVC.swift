//
//  SignUpVC.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/2/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var fnameTxt: UITextField!
    @IBOutlet weak var lnameTxt: UITextField!
    
    var utype: String = "Error"
    var umessage: String = "Error in Signup"
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func giveAlert(){
        let alert = UIAlertController(title: utype, message: umessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        return
    }
    
    @IBAction func RegisterAction(_ sender: Any) {
        
        let usernameVal = usernameTxt.text
        if usernameVal == nil{
            return
        }
        let username = usernameVal!
        if(username.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            let alert = UIAlertController(title: "ALERT", message: "Username Field is empty!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let emailVal = emailTxt.text
        if emailVal == nil{
            return
        }
        let email = emailVal!
        if(email.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            let alert = UIAlertController(title: "ALERT", message: "Email Field is empty!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        let passwordVal = passwordTxt.text
        if passwordVal == nil{
            return
        }
        let password = passwordVal!
        if(password.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            let alert = UIAlertController(title: "ALERT", message: "Password Field is empty!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let fnameVal = fnameTxt.text
        if fnameVal == nil{
            return
        }
        let fname = fnameVal!
        if(fname.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            let alert = UIAlertController(title: "ALERT", message: "First Name Field is empty!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        let lnameVal = lnameTxt.text
        if lnameVal == nil{
            return
        }
        let lname = lnameVal!
        if(lname.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            let alert = UIAlertController(title: "ALERT", message: "Last Name Field is empty!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let json: [String: Any] = ["username": username,
                                   "password": password,
                                   "role": "user",
                                   "email": email,
                                   "fname": fname,
                                   "lname": lname]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: "http://127.0.0.1:5000/createAccount")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200{
                    self.utype = "Error"
                    self.umessage = "Error In account creation"
                    return
                }
                if httpResponse.statusCode == 200 {
                    self.utype = "Success"
                    self.umessage = "Account Created Successfully"
                    return
                }
                if httpResponse.statusCode == 406{
                    self.utype = "Error"
                    self.umessage = "Username Taken"
                    return
                }
                
                
            }
            

        }
        task.resume()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.giveAlert()
        }
        
        
        
    }
    

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
