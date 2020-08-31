//
//  DHTextFieldType.swift
//  DailyHub
//
//  Created by Karthi on 05/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct DHTextFieldType: Codable {
    
   private enum CodingKeys: String, CodingKey {
        case padding
        case textProperties
        case viewProperties
    }
    
    let padding: DHEdgeInset?
    let textProperties: DHTextProperties?
    let viewProperties: DHViewProperties?
}

struct DHEdgeInset: Codable {
    private enum CodingKeys: String, CodingKey {
        case top
        case left
        case bottom
        case right
    }
    
    let top: CGFloat?
    let left: CGFloat?
    let bottom: CGFloat?
    let right: CGFloat?
    
    var edgeInset: EdgeInsets {
        return EdgeInsets(top: (top ?? CGFloat(0.0)),
                          leading: (left ?? CGFloat(0.0)),
                          bottom: (bottom ?? CGFloat(0.0)),
                          trailing: (right ?? CGFloat(0.0)))
    }
    
}

struct DHUIEdgeInset: Codable {
    private enum CodingKeys: String, CodingKey {
        case top
        case left
        case bottom
        case right
    }
    
    let top: CGFloat?
    let left: CGFloat?
    let bottom: CGFloat?
    let right: CGFloat?
    
    var edgeInset: UIEdgeInsets {
        return UIEdgeInsets(top: -(top ?? CGFloat(0.0)),
                            left: -(left ?? CGFloat(0.0)),
                            bottom: -(bottom ?? CGFloat(0.0)),
                            right: -(right ?? CGFloat(0.0)))
    }
    
}
