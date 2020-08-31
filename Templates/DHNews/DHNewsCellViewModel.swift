//
//  DHNewsCellViewModel.swift
//  DailyHub
//
//  Created by Karthi on 21/06/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import UIKit

class DHNewsCellViewModel: NSObject {
    
    var article: DHArticleModel?
    var title: String {
        return article?.title ?? ""
    }
    
    var descriptionText: String {
        return article?.description ?? ""
    }
    
    var imageUrl: URL {
        return URL(string: article?.urlToImage ?? "https://images.livemint.com/img/2020/08/02/600x338/Bandhanbank_1596365798223.JPG")!
    }
}
