//
//  DHArticleTableViewCell.swift
//  DailyHub
//
//  Created by Karthi on 07/06/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import UIKit

class DHArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: DHLabel!
    
    @IBOutlet weak var titleLabel: DHLabel!
  
    @IBOutlet weak var thumbnailImage: DHImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.thumbnailImage.image = UIImage(named: "Placeholder")
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.thumbnailImage.image = UIImage(named: "Placeholder")
    }
    
    func configure(cellViewModel: DHNewsCellViewModel) {
        guard let dhStyles = dhStyles, let labels = dhStyles.labels, let imageViews = dhStyles.imageViews else {
            return
        }
        
        self.titleLabel.labelType = labels.title
        self.descriptionLabel.labelType = labels.description
        self.thumbnailImage.imageViewStyle = imageViews.thumbNail
        self.titleLabel.text = cellViewModel.title
        self.descriptionLabel.text = cellViewModel.descriptionText
        cellViewModel.article?.getArticleImage() {[weak self] (image) in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
               strongSelf.thumbnailImage.image = image
            }
            
        }
    }
    
}
