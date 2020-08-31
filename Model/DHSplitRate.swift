//
//  DHSplitRate.swift
//  DailyHub
//
//  Created by Karthi on 28/06/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation

struct DHSplitRate: Codable {
    private enum CodingKeys: CodingKey {
        case unit
        case chargePerUnit
    }
    var unit: Float?
    var chargePerUnit: Float?
}
