//
//  TransactionData.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/14/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import Foundation


class TransactionData {
    
    var from : String = ""
    var to : String = ""
    var quantity : Int = 0
    var price : Double = 0
    
    
    init(from: String, to : String, quantity : Int , price : Double) {
        self.from = from
        self.to = to
        self.quantity = quantity
        self.price = price
    }

}
