//
//  DHNewsModel.swift
//  DailyHub
//
//  Created by Karthi on 07/06/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import UIKit

struct DHArticles: Codable {
    private enum CodingKeys: CodingKey {
        case articles
    }
    var articles: [DHArticleModel]
}

class DHArticleModel: Codable {
    private enum CodingKeys: CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
    var source: DHArticleSourceModel?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    var cachedImage: UIImage?
    
    func getArticleImage(completion: @escaping((UIImage?)->())) {
        if let cachedImage = cachedImage {
            completion(cachedImage)
        } else {
            guard let _ = urlToImage, let _ = URL(string: urlToImage ?? "") else {
                return
            }
            // self.cachedImage = UIImage(named: "Placeholder")
            let dataTask = URLSession.shared.dataTask(with: URL(string: urlToImage!)!) { [weak self] (data, response, error) in
                guard let strongSelf = self else {
                    return
                }
                guard let imageData = data else {
                   // completion(strongSelf.cachedImage)
                    return
                }
                
                let thumbNailImage = UIImage(data: imageData)
                DispatchQueue.main.async {
                    strongSelf.cachedImage = thumbNailImage
                    completion(thumbNailImage)
                }
            }
            dataTask.resume()
        }
    }
}

