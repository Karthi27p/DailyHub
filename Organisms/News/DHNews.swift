//
//  DHNewsCell.swift
//  DailyHub
//
//  Created by Karthi on 30/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class DHNews: UIView, DHNewsView {
    
    private let nibName = "DHNews"
    
    
    @IBOutlet weak var newsText: DHNewsText!
    
    @IBOutlet weak var thumbNail: DHImageView!
    
    var contentView:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit(nibName)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit(nibName)
    }
    
    public func setData(_ item: DHNewsCellViewModel){
        
        
        if item.title.count > 0 {
            newsText.titleLabel.text = item.title
        } else {
            newsText.titleLabel.isHidden = true
        }
        
        if item.description.count > 0 {
            newsText.descriptionLabel.text = item.descriptionText
        } else {
            newsText.descriptionLabel.isHidden = true
        }
        
        item.article?.getArticleImage() {[weak self] (image) in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.thumbNail.image = image
            }
            
        }
        
        guard let styles = dhStyles, let labelStyle = styles.labels, let imageViewStyle = styles.imageViews else {
            return
        }
        
        newsText.titleLabel.labelType = labelStyle.title
        newsText.descriptionLabel.labelType = labelStyle.description
        thumbNail.imageViewStyle = imageViewStyle.thumbNail
        
    }
    
    
}
