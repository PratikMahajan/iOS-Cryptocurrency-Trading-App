//
//  SellView.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/14/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import UIKit

class SellView: UIViewController {

    @IBOutlet weak var quantity: UITextField!
    
    @IBAction func sellAction(_ sender: Any) {
        
        sellCoins()
        
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
    
    
    
    
    func sellCoins(){
        // prepare json data
        
        let rate = getCurrentRate()
        let username = getUsername()
        let quant = getQuantity()
        
        let json: [String: Any] = ["address": username,
                                   "quantity": quant,
                                   "amount": rate]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: "http://127.0.0.1:5050/sell")!
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
        task.resume()
    }
    
    
    
    func sendAlert(){
        let alert = UIAlertController(title: "ALERT", message: "Sell Requested", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
//                self.amount = responseJSON["Price"] as! Double
                rate = responseJSON["Price"] as! Double
                
                
            }
        }
        
        task.resume()
        return rate
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
