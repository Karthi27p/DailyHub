//
//  DHTitleLabelType.swift
//  DailyHub
//
//  Created by Karthi on 23/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import UIKit

struct DHLabelType: Codable {
    private enum CodingKeys: String, CodingKey {
        case padding
        case numberOfLines
        case textProperties
        case viewProperties
    }
    
    let padding: DHUIEdgeInset?
    let numberOfLines: Int?
    let textProperties: DHTextProperties?
    let viewProperties: DHViewProperties?
}
