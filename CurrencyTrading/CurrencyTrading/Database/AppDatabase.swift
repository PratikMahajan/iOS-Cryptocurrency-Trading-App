//
//  AppDatabase.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/2/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import Foundation
import GRDB

/// A type responsible for initializing the application database.
///
/// See AppDelegate.setupDatabase()
var dbQueue: DatabaseQueue!
struct AppDatabase {
    
    /// Creates a fully initialized database at path
    static func openDatabase(atPath path: String) throws -> DatabaseQueue {
        dbQueue = try DatabaseQueue(path: path)
        
        // Use DatabaseMigrator to define the database schema
        try migrator.migrate(dbQueue)
        return dbQueue
    }
    
    /// The DatabaseMigrator that defines the database schema.
    ///
    /// This migrator is exposed so that migrations can be tested.
    // See https://github.com/groue/GRDB.swift/#migrations
    static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        migrator.registerMigration("user") { db in
            // Create a table
            try db.create(table: "user") { t in
                // An integer primary key auto-generates unique IDs
                t.column("user_id", .text).primaryKey()

                t.column("username", .text).notNull()
                
                t.column("password", .text).notNull()
                
                t.column("role", .text).notNull()
                t.column("verify", .integer).notNull()
                t.column("balance", .double).notNull()
                
                
            }
        }
        
        
        
        //        // Migrations for future application versions will be inserted here:
        //        migrator.registerMigration(...) { db in
        //            ...
        //        }
        
        return migrator
    }
}
