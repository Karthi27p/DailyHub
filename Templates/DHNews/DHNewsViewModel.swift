//
//  DHNewsViewModel.swift
//  DailyHub
//
//  Created by Karthi on 07/06/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import UIKit

class DHNewsViewModel {
    
    func fetchNewsData(category: String?, completion: @escaping((Any?, Error?) -> ())) {
        var newsFeedUrl = "https://newsapi.org/v2/top-headlines?country=in&apiKey=7f286201a8c84bf2a9f2ad03ce11866a"
        if let category = category, category.count > 0 {
            newsFeedUrl = "https://newsapi.org/v2/top-headlines?country=in&category=\(category)&apiKey=7f286201a8c84bf2a9f2ad03ce11866a"
        }
        let requestUrl = URLRequest(url: URL(string: newsFeedUrl)!)
        print(DHArticles.self)
        DHApiService.fetchData(requestUrl: requestUrl, resultStruct: DHArticles.self) { (data, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
            
        }
    }    
}
