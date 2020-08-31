//
//  DHNewsCell.swift
//  DailyHub
//
//  Created by Karthi on 30/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import UIKit

class DHNewsCell: UITableViewCell, DHTableViewCell {
    
    @IBOutlet weak var newsView: DHNews!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func getArticleView() -> DHNewsView? {
        return self.newsView
    }
}
