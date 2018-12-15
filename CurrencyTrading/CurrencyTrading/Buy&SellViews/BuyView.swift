//
//  BuyView.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/14/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import UIKit

class BuyView: UIViewController {

    @IBOutlet weak var quantity: UITextField!
    var amount : Double = 0.0
    var myrate = 0.0
    
    var mybalance = 0.0
    var mycoins = 0.0
    
    
    
    @IBAction func buyAction(_ sender: Any) {
        buyCoins()
        
    }
    
    
    
    func addCoins(amount: Int){
        // prepare json data
        let json: [String: Any] = ["address": getUsername(),
                                   "amount": amount]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: "http://127.0.0.1:5000/addCoins")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200{
                    print ("error in adding money")
                    return
                }
            }
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                
                
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func addMoney(amount: Double){
        // prepare json data
        let json: [String: Any] = ["address": getUsername(),
                                   "amount": amount]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: "http://127.0.0.1:5000/addMoney")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200{
                    print ("error in adding money")
                    return
                }
            }
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                let newBal = responseJSON["balance"] as! Double
                self.Insert(balance: newBal)
                
                
            }
        }
        task.resume()
    }
    
    
    func Insert(balance:Double){
        do{
            try dbQueue.write { db in
                try db.execute(
                    "update user set balance = \(balance)")
                print ("added")
            }}
        catch{
            print ("not added")
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    func getQuantity() -> Int{
        
        let quantval = quantity.text
        if quantval == nil{
            return 0
        }
        var quant = quantval!
        if(quant.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            let alert = UIAlertController(title: "ALERT", message: "Quantity Field is empty!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return 0
            
        }
        var final: Int
        if let yk = Int(quant){
            if(yk<0){
                let alert = UIAlertController(title: "ALERT", message: "Enter Proper Quantity", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return 0
            }
            
            final = yk
        }else{
            let alert = UIAlertController(title: "ALERT", message: "Quantity in Numbers", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return 0
        }
        return final
        
    }
    
    
    
    
    
    func getUsername() -> String{
        var username = ""
        do{
            try dbQueue.read { db in
                let user = try User.fetchAll(db)
                username = user[0].username
            
            }
        }
        catch{
            print("Error in reading data")
        }
        
        return username
    }
    
    
    func loadMoney(){
        
        // prepare json data
        let json: [String: Any] = ["address": getUsername()]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: "http://127.0.0.1:5000/getBalance")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200{
                    print ("error in getting money")
                    return
                }
            }
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                self.mybalance = responseJSON["balance"] as! Double
                
                
                
            }
        }
        task.resume()
    }
    
    
    
    func buyCoins(){
        // prepare json data
        loadMoney()
        var rate = 0.0
        rate = self.getCurrentRate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let username = self.getUsername()
            let quant = self.getQuantity()
            let totalamt = Double(quant) * self.myrate
            if self.mybalance < (totalamt) {
                let alert = UIAlertController(title: "ALERT", message: "Insufficient Balance", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                self.quantity.text = ""
                return
            }
            
            
            self.addMoney(amount: totalamt * -1)
            self.addCoins(amount: quant)
            
            if quant == 0{
                return
            }
            let json: [String: Any] = ["address": username,
                                       "quantity": quant,
                                       "amount": self.myrate]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            // create post request
            let url = URL(string: "http://127.0.0.1:5050/buy")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // insert json data to the request
            request.httpBody = jsonData
            
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode != 200{
                        print ("failed sell")
                        return
                    }
                }
                
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    self.sendAlert()
                    
                }
            }
            self.sendAlert()
            task.resume()
        }
        
        
    }
    
    
    func sendAlert(){
        let alert = UIAlertController(title: "ALERT", message: "Buy Requested", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        quantity.text = ""
        return
    }
    
    
    func getCurrentRate() -> Double{
        
        var rate: Double = 0.0
        let url = URL(string: "http://127.0.0.1:5050/dynamicPrice")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200{
                    print ("error in getting pricing information")
                    return
                }
            }
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                self.amount = responseJSON["Price"] as! Double
                rate = responseJSON["Price"] as! Double
                self.myrate = rate
                
            }
        }
        
        task.resume()
        return rate
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
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
