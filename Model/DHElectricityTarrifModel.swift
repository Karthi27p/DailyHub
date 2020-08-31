//
//  DHElectricityTarrifModel.swift
//  DailyHub
//
//  Created by Karthi on 28/06/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation

struct DHElectricityTarrifModel: Codable {
   private enum CodingKeys: CodingKey {
        case status
        case totalResults
        case type
        case cutOffLimit
        case biMonthlyConsumption
    }
    
    var status: String?
    var totalResults: Int?
    var type: String?
    var cutOffLimit: Int?
    var biMonthlyConsumption: [DHBiMonthlyConsumption]
}

struct DHBillDetails {
    var billCatergory: String?
    var billValue: String?
}
