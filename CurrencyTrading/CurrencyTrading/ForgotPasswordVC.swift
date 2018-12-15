//
//  ForgotPasswordVC.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/2/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBAction func backAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
