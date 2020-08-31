//
//  DHTextType.swift
//  DailyHub
//
//  Created by Karthi on 09/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import UIKit

struct DHTextType: Codable {
    
   private enum CodingKeys: String, CodingKey {
        case textProperties
    }
    
    
    let textProperties: DHTextProperties?
}
