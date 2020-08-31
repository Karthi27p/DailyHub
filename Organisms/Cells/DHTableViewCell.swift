//
//  DHTableViewCell.swift
//  DailyHub
//
//  Created by Karthi on 30/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import UIKit

protocol DHTableViewCell where Self: UITableViewCell {
    func getArticleView() -> DHNewsView?
}

protocol DHNewsView {
    func setData(_ item: DHNewsCellViewModel)
}
