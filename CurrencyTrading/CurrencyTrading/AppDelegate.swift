//
//  AppDelegate.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/2/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import UIKit
import GRDB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rowCount: Int = 0
    var role: String = ""


    //-------------------------------------------------------------
    // Database Connection
    var dbQueue: DatabaseQueue!
    
    private func setupDatabase(_ application: UIApplication) throws {
        let databaseURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("db2.sqlite")
        dbQueue = try AppDatabase.openDatabase(atPath: databaseURL.path)
        
        // Be a nice iOS citizen, and don't consume too much memory
        // See https://github.com/groue/GRDB.swift/#memory-management
        dbQueue.setupMemoryManagement(in: application)
    }
    
    //--------------------------------------------------------------
    //database reading
    
    func getDatabase(){
        do{
            try dbQueue.read { db in
                rowCount = try User.fetchCount(db)
            }}
        catch{
            print ("error reading db")
        }
        
    }
    
    func getData(){
        do{
            try dbQueue.read { db in
                let user = try User.fetchAll(db)
                role = user[0].role
            }
        }
        catch{
            print("Error in reading data")
        }
        
    }
    
    func testInsert(){
        //
        //        do{
        //            try dbQueue.write { db  in
        //                var player = User(user_id: "test1", username: "test1", password: "test1", role: "user")
        //                try player.insert(db)
        //            }
        //        }
        //        catch{
        //            print ("Error in insert")
        //        }
        do{
            try dbQueue.write { db in
                try db.execute(
                    "delete from user")
                print ("deleted")
            }}
        catch{
            print ("not deleted")
        }
    }
    
    
    
    //--------------------------------------------------------------
    
    func changeEntry(role : String){
        if role=="user" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "userwindow")
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        if role == "admin" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "verificationwindow")
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        
        
    }
    
    
    //--------------------------------------------------------------
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        try! setupDatabase(application)
//        testInsert()
        getDatabase()
        if rowCount>0{
            getData()
            changeEntry(role: role)
        }
       
        
        
        
        

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

