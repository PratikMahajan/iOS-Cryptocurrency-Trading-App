//
//  VerificationApprovedNew.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/13/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import UIKit
import AWSCore
import AWSS3

class VerificationApprovedNew: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    
    @IBOutlet weak var table: UITableView!
    var elements : [String] = []
    var searchResult: [String] = []
    var searchController = UISearchController(searchResultsController: nil )
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            print (searchText)
            searchResult = elements.filter { element in
                return element.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            searchResult  = elements
        }
        table.reloadData()
    }
    
    
    func getS3Objects(){
        
        let myIdentityPoolId = "us-east-1:5ffdd6d8-cf99-40ad-abd3-ecbed3610cec"
        let credentialsProvider:AWSCognitoCredentialsProvider = AWSCognitoCredentialsProvider(regionType: AWSRegionType.USEast1, identityPoolId: myIdentityPoolId)
        let configuration = AWSServiceConfiguration(region: AWSRegionType.USEast1, credentialsProvider:credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        AWSS3.register(with: configuration!, forKey: "defaultKey")
        let s3 = AWSS3.s3(forKey: "defaultKey")
        
        let listRequest: AWSS3ListObjectsRequest = AWSS3ListObjectsRequest()
        listRequest.bucket = "aedprojectvalidate"
        
        s3.listObjects(listRequest).continueWith { (task) -> AnyObject? in
            for object in (task.result?.contents)! {
                print("Object key = \(object.key!)")
                self.elements.append(object.key!)
            }
            return nil
        }
        
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
        self.performSegue(withIdentifier: "showapproveddetail", sender: elements[indexPath.row])
        
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
        if let detailedview = segue.destination as? AdminDocDetailVC {
            detailedview.key = sender as! String
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        getS3Objects()
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
