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
    
    
    
    @IBAction func selectedSegment(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0 : buyContainer.isHidden = false
                sellContainer.isHidden = true
        case 1: buyContainer.isHidden = true
                sellContainer.isHidden = false
        default: break;
            
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buyContainer.isHidden = false
        sellContainer.isHidden = true
        
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
