//
//  AdminDocDetailVC.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/6/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import UIKit
import AWSS3

class AdminDocDetailVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var verSwitch: UISwitch!
    @IBOutlet weak var navBar: UINavigationBar!
    
 
    
    var completionHandler: AWSS3TransferUtilityDownloadCompletionHandlerBlock?
    let transferUtility = AWSS3TransferUtility.default()
    
    var key : String = ""
    
    
    @IBAction func updateAction(_ sender: Any) {
        
        setVerification()
    }
    
    
    func getVerification(){
        
        // prepare json data
        let json: [String: Any] = ["address": key]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: "http://127.0.0.1:5000/getVerify")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200{
                    print ("error in query")
                    self.verSwitch.setOn(false, animated: true)
                    return
                }
            }
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                        if let responseJSON = responseJSON as? [String: Any] {
                            let bool = responseJSON["bool"] as! Int
                            
                            if bool == 1{
                                self.verSwitch.setOn(true, animated: true)
                            }
                            else{
                                self.verSwitch.setOn(false, animated: true)
                            }
            //                let usr = responseJSON["userid"] as! String
                        }
        }
        task.resume()
        
        
        
        
        
        
    }
    
    
    func setVerification(){
        var status = 0
        if verSwitch.isOn{
            status = 1
        }
        // prepare json data
        let json: [String: Any] = ["address": key,
                                   "bool": status]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: "http://127.0.0.1:5000/setVerify")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200{
                    print ("error in query")
                    return
                }
            }
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//            if let responseJSON = responseJSON as? [String: Any] {
//                let transfer = responseJSON["role"] as! String
//                let usr = responseJSON["userid"] as! String
//            }
        }
        task.resume()
        
    }
    
    
    
    
    
    func getImage(){
        
        DispatchQueue.main.async(execute: {
            self.progressView.progress = 0
        })
        
        self.imageView.image = nil;
        
        let expression = AWSS3TransferUtilityDownloadExpression()
        expression.progressBlock = {(task, progress) in
            DispatchQueue.main.async(execute: {
                if (self.progressView.progress < Float(progress.fractionCompleted)) {
                    self.progressView.progress = Float(progress.fractionCompleted)
                }
            })
        }
        
        
        self.completionHandler = { (task, location, data, error) -> Void in
            DispatchQueue.main.async(execute: {
                if let error = error {
                    NSLog("Failed with error: \(error)")
                }
                else{
                    self.imageView.image = UIImage(data: data!)
                }
            })
        }
        
        transferUtility.downloadData(
            fromBucket: "aedprojectvalidate",
            key: self.key,//"this",
            expression: expression,
            completionHandler: completionHandler).continueWith { (task) -> AnyObject? in
                if let error = task.error {
                    NSLog("Error: %@",error.localizedDescription);
                    DispatchQueue.main.async(execute: {
                        print ("failed")
                    })
                }
                
                if let _ = task.result {
                    DispatchQueue.main.async(execute: {
                        print("Downloading")
                    })
                    NSLog("Download Starting!")
                    // Do something with uploadTask.
                }
                return nil;
        }
 
}
    
    
    
    
    
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.verSwitch.setOn(false, animated: true)
        getVerification()
        getImage()
        
        navBar.barTintColor = UIColor(patternImage: UIImage(named: "background.png")!)
        navBar.isTranslucent = true;
        
        //        if let sb = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
        //            sb.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.9, alpha: 1)
        //            // if you prefer a light gray under there...
        //            //sb.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.9, alpha: 1)
        //        }
        
        
        
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
