//
//  TransferVC.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/2/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import UIKit

class TransferVC: UIViewController {

    @IBOutlet weak var buyContainer: UIView!
    @IBOutlet weak var sellContainer: UIView!
    
    @IBOutlet weak var currentRate: UILabel!
    @IBOutlet weak var currentBalance: UILabel!
    @IBOutlet weak var currentCoins: UILabel!
    
    var username:String = ""
    var mybalance = 0.0
    var mycoins = 0.0
    var myrate = 0.0
    
    
    var timer = Timer()
    var time = 0
    
    
    @objc func increaseTimer(){
        time+=1
        //updating lable here
        getCurrentRate()
    }
    
    func startTime() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.increaseTimer), userInfo: nil, repeats: true)
        
    }
    
    func resetTimer() {
        timer.invalidate()
        time = 0
    }
    func pauseTimer() {
        timer.invalidate()
    }
    
    

    
    
    
    
    
    @IBAction func selectedSegment(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0 : buyContainer.isHidden = false
                sellContainer.isHidden = true
        case 1: buyContainer.isHidden = true
                sellContainer.isHidden = false
        default: break;
            
        }
        
        
    }
    
    
    
    
    func loadMoney(){
        
        // prepare json data
        let json: [String: Any] = ["address": username]
        
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
        self.currentBalance.text = "\(self.mybalance)"
        task.resume()
    }
    
    
    func loadCoins(){
        
        
        // prepare json data
        let json: [String: Any] = ["address": username]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: "http://127.0.0.1:5000/getCoins")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200{
                    print ("error in getting coins")
                    return
                }
            }
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                self.mycoins = responseJSON["balance"] as! Double
                
                
            }
        }
        
        self.currentCoins.text = "\(self.mycoins)"
        task.resume()
    }
    
    
    func getInfo(){
        do{
            try dbQueue.read { db in
                let user = try User.fetchAll(db)
                self.username = user[0].username
            }
        }
        catch{
            print("Error in reading data")
        }
    }
    
    
    
    
    func getCurrentRate(){
        

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
                self.myrate = responseJSON["Price"] as! Double
//                print (self.myrate)
                
                
            }
        }
        
        self.currentRate.text = "\(self.myrate)"
        task.resume()   
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        loadCoins()
        loadMoney()
        getCurrentRate()
        buyContainer.isHidden = false
        sellContainer.isHidden = true
        self.currentCoins.text = "\(self.mycoins)"
        self.currentBalance.text = "\(self.mybalance)"
        self.currentRate.text = "\(self.myrate)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        resetTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getInfo()
        loadCoins()
        loadMoney()
        getCurrentRate()
        startTime()
        buyContainer.isHidden = false
        sellContainer.isHidden = true
        self.currentCoins.text = "\(self.mycoins)"
        self.currentBalance.text = "\(self.mybalance)"
        self.currentRate.text = "\(self.myrate)"
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
