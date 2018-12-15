//
//  TrnasactionDetailsVC.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/14/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import UIKit

class TrnasactionDetailsVC: UIViewController {

    
    var key : TransactionData = TransactionData(from: "", to: "", quantity: 0, price: 0.0)
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var fromval: UILabel!
    @IBOutlet weak var toval: UILabel!
    @IBOutlet weak var quantityval: UILabel!
    @IBOutlet weak var rateval: UILabel!
    @IBAction func backAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func setValues(){
        
        fromval.text = key.from
        toval.text = key.to
        quantityval.text = "\(key.quantity)"
        rateval.text = "\(key.price)"
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.barTintColor = UIColor(patternImage: UIImage(named: "background.png")!)
        navBar.isTranslucent = true;
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        setValues()
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
