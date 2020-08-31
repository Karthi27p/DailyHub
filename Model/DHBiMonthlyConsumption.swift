//
//  DHBiMonthlyConsumption.swift
//  DailyHub
//
//  Created by Karthi on 28/06/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation

struct DHBiMonthlyConsumption: Codable {
    private enum codingKeys: CodingKey {
        case maxLimit
        case fixedCharges
        case splitRate
    }
    
    var maxLimit: Int
    var fixedCharges: Float
    var splitRate: [DHSplitRate]
}
