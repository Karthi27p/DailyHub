//
//  DHThumbnailImageView.swift
//  DailyHub
//
//  Created by Karthi on 23/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import UIKit

struct DHImageViewType: Codable {
    private enum CodingKeys: String, CodingKey {
        case padding
        case viewProperties
    }
    let padding: DHUIEdgeInset?
    let viewProperties: DHViewProperties?
}
