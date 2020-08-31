//
//  DHArticleSourceModel.swift
//  DailyHub
//
//  Created by Karthi on 07/06/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation

struct DHArticleSourceModel: Codable {
    private enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    let id: String?
    let name: String?
}
