//
//  Item.swift
//  SoccerManagerIOS
//
//  Created by Himay on 1/20/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
