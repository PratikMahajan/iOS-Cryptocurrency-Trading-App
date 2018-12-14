//
//  User.swift
//  CurrencyTrading
//
//  Created by Pratik Mahajan on 12/3/18.
//  Copyright © 2018 Pratik Mahajan. All rights reserved.
//

import Foundation
import GRDB

struct User {
    var user_id: String
    var username: String
    var password: String
    var role: String
    var verify: Int
    var balance: Double
}

// MARK: - Persistence
extension User:  Codable, FetchableRecord, MutablePersistableRecord {
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_id = try values.decode(String.self, forKey: .user_id)
        username = try values.decode(String.self, forKey: .username)
        password = try values.decode(String.self, forKey: .password)
        role = try values.decode(String.self, forKey: .role)
        verify = try values.decode(Int.self, forKey: .verify)
        balance = try values.decode(Double.self, forKey: .balance)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(user_id, forKey: .user_id)
        try container.encode(username, forKey: .username)
        try container.encode(password, forKey: .password)
        try container.encode(role, forKey: .role)
        try container.encode(verify, forKey: .verify)
        try container.encode(balance, forKey: .balance)
        
        
    }
    
    
    // Add ColumnExpression to Codable's CodingKeys so that we can use them
    // as database columns.
    // See https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types
    // for more information about CodingKeys.
    private enum CodingKeys: String, CodingKey, ColumnExpression {
        case user_id, username, password, role, verify, balance
    }
    
// Update a player id after it has been inserted in the database.
//    mutating func didInsert(with rowID: String, for column: String?) {
//        user_id = rowID
//    }
}

//// MARK: - Database access
//extension User {
//    static func orderedByName() -> QueryInterfaceRequest<User> {
//        return User.order(CodingKeys.username)
//    }
//
//}

