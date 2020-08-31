//
//  DHViewType.swift
//  DailyHub
//
//  Created by Karthi on 03/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import UIKit

struct DHViewProperties: Codable {
    
   private enum CodingKeys: String, CodingKey {
        case opacity
        case bgColor
        case border
        case edgeCornerRadius
        case cornerRadius
    }
    
    let opacity: CGFloat?
    let bgColor: String?
    let border: DHBorderStyle?
    let edgeCornerRadius: CGFloat?
    let cornerRadius: DHCornerRadiusStyle?
}

struct DHBorderStyle: Codable {
    
    private enum CodingKeys: String, CodingKey {

        case color
        case width
    }
    
    let color: String?
    let width: CGFloat?
    
}

struct DHCornerRadiusStyle: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
    
    let topLeft: CGFloat?
    let topRight: CGFloat?
    let bottomLeft: CGFloat?
    let bottomRight: CGFloat?
}
