//
//  AddBalanceVC.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/14/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import UIKit

class AddBalanceVC: UIViewController {

    @IBOutlet weak var card: UITextField!
    @IBOutlet weak var cvv: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mm: UITextField!
    @IBOutlet weak var dd: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var addMoneyBtn: UIButton!
    
    @IBOutlet weak var navBar: UINavigationBar!
    var username : String = ""
    
    @IBOutlet weak var AddAction: UIButton!
    
    @IBAction func AddPressed(_ sender: Any) {
        executeAdd()
    }
    
    
    func executeAdd() {
        
        let cardval = card.text
        if cardval == nil{
            return
        }
//        print (cardval)
        var cardvalue = cardval!
        
        if(cardvalue.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            let alert = UIAlertController(title: "ALERT", message: "Card Number Field is empty!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        var cardu: Int64
        if let yk = Int64(cardvalue){
            if(yk < 1000000000000000 || yk > 9999999999999999 ){
                let alert = UIAlertController(title: "ALERT", message: "Enter Proper Card", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            cardu = yk
        }else{
            let alert = UIAlertController(title: "ALERT", message: "Card in Numbers", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        
        let cvvval = cvv.text
        if cvvval == nil{
            return
        }
        var cvvvalue = cvvval!
        if(cardvalue.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            let alert = UIAlertController(title: "ALERT", message: "CVV Field is empty!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        var cvvu: Int
        if let yk = Int(cvvvalue){
            if(yk > 999 || yk < 100){
                let alert = UIAlertController(title: "ALERT", message: "Enter Proper CVV", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            cvvu = yk
        }else{
            let alert = UIAlertController(title: "ALERT", message: "CVV in Numbers", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        let nameval = name.text
        if nameval == nil{
            return
        }
        var namevalue = nameval!
        if(namevalue.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            let alert = UIAlertController(title: "ALERT", message: "Name Field is empty!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        
        let mmval = mm.text
        if mmval == nil{
            return
        }
        var mmvalue = mmval!
        if(mmvalue.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            let alert = UIAlertController(title: "ALERT", message: "MM Field is empty!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        var mmu: Int
        if let yk = Int(mmvalue){
            if(yk > 12){
                let alert = UIAlertController(title: "ALERT", message: "Enter Proper MM", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            mmu = yk
        }else{
            let alert = UIAlertController(title: "ALERT", message: "MM in Numbers", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        let ddval = dd.text
        if ddval == nil{
            return
        }
        var ddvalue = ddval!
        if(ddvalue.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            let alert = UIAlertController(title: "ALERT", message: "DD Field is empty!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        var ddu: Int
        if let yk = Int(ddvalue){
            if(yk > 31){
                let alert = UIAlertController(title: "ALERT", message: "Enter Proper DD", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            ddu = yk
        }else{
            let alert = UIAlertController(title: "ALERT", message: "DD in Numbers", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        
        
        
        let Amountval = amount.text
        if Amountval == nil{
            return
        }
        var amountvalue = Amountval!
        if(amountvalue.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            let alert = UIAlertController(title: "ALERT", message: "Amount Field is empty!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        var amountu: Double
        if let yk = Double(amountvalue){
            if(yk < 0){
                let alert = UIAlertController(title: "ALERT", message: "Enter Proper Amount", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            amountu = yk
        }else{
            let alert = UIAlertController(title: "ALERT", message: "Amount in Numbers", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        
        
        
        
        self.addMoney(amount: amountu)
        let alert = UIAlertController(title: "ALERT", message: "Money Added", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        return
        
        
        
    }
    
    
    
    
    
    func addMoney(amount: Double){
        // prepare json data
        let json: [String: Any] = ["address": username,
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
    
    
    
    
    @IBAction func backAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        navBar.barTintColor = UIColor(patternImage: UIImage(named: "background.png")!)
        navBar.isTranslucent = true;
        
        
        addMoneyBtn.layer.cornerRadius = 15
        addMoneyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
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
