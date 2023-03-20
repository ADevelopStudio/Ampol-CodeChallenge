//
//  User.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import Foundation

struct User {
    static var current = User()
    
    var name: String = "John"
    var authToken: String = "USER_TOKEN"
    
    var homeUsageCoastPerKW: Double = 0.27
}
