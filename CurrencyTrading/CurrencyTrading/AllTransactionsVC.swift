//
//  AllTransactionsVC.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/14/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import UIKit

class AllTransactionsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    
    @IBOutlet weak var table: UITableView!
    var elements : [String] = []
    var finalRes: [String] = []
    var searchController = UISearchController(searchResultsController: nil )
    var username = ""
    
    var transactions : [TransactionData] = []
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            //            print (searchText)
            elements = finalRes.filter { element in
                return element.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            print ("nothing there")
            elements  = finalRes
        }
        //        print (elements)
        //        print (finalRes)
        table.reloadData()
    }
    
    
    func getData(){
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
    
    
    func getObjects(){
        // prepare json data
        let json: [String: Any] = ["address": self.username]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: "http://127.0.0.1:5050/getTransactions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200{
                    print ("error in fetching transactions")
                    return
                }
            }
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            for ele in responseJSON as! NSArray{
                if let responseJSON = ele as? [String: Any] {
                    //                let transfer = responseJSON["role"] as! String
                   let from = responseJSON["from"] as! String
                   let to = responseJSON["to"] as! String
                    let quantity = responseJSON["quantity"] as! Int
                    let price = responseJSON["price"] as! Double
                    self.transactions.append(TransactionData(from: from, to: to, quantity: quantity, price: price))
                    
                    var data = "From: "+from+" To: "+to
                    self.elements.append(data)
                    
            }
            
            }
        }
        task.resume()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.table.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.performSegue(withIdentifier: "showdetails", sender: transactions[indexPath.row])
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCellVC()
        cell.textLabel?.text = elements[indexPath.row]
        //        //        cell.imageView?.image = UIImage(named: "Image")
        //        let url = URL(string: vehicle.photo)
        //        if let data = try? Data(contentsOf: url!)
        //        {
        //            let image: UIImage = UIImage(data: data)!
        //            cell.imageView?.image = image
        //        }
        return cell
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let detailedview = segue.destination as? TrnasactionDetailsVC {
            detailedview.key = sender as! TransactionData
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        getData()
        getObjects()
        
        super.viewDidLoad()
        
        self.searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            //            Add searchbar controller in header
            self.table.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        
        
        
        table.dataSource = self
        table.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.table.reloadData()
            
        }
        
        self.table.reloadData()
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
