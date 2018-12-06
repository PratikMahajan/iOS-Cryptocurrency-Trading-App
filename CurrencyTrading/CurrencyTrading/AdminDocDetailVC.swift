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

    @IBOutlet weak var `switch`: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var completionHandler: AWSS3TransferUtilityDownloadCompletionHandlerBlock?
    let transferUtility = AWSS3TransferUtility.default()
    
    
    
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
            key: "this",
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
    
    
    
    @IBAction func updateButton(_ sender: Any) {
        
        
    }
    
    
    
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()

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
