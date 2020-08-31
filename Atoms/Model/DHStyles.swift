//
//  DHStyles.swift
//  DailyHub
//
//  Created by Karthi on 08/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import UIKit

struct DHStyles: Codable {
    private enum CodingKeys: String, CodingKey {
        case textField
        case text
        case imageViews
        case labels
    }
    let textField: DHTextFieldType?
    let text: DHTextType?
    let imageViews: DHStyleImageView?
    let labels: DHStyleLabel?
}

struct DHStyleImageView: Codable {
    private enum CodingKeys: String, CodingKey {
        case thumbNail
    }
    let thumbNail: DHImageViewType?
}

struct DHStyleLabel: Codable {
    private enum CodingKeys: String, CodingKey {
        case title
        case description
    }
    
    let title: DHLabelType?
    let description: DHLabelType?
}

