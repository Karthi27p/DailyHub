//
//  DHTextProperties.swift
//  DailyHub
//
//  Created by Karthi on 05/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import UIKit

struct DHTextProperties: Codable {
    private enum CodingKeys: CodingKey {
        case textColor
        case fontSize
        case isBold
    }
    
    let textColor: String?
    let fontSize: CGFloat?
    let isBold: Bool?
}
