//
//  DHImageView.swift
//  DailyHub
//
//  Created by Karthi on 23/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import UIKit

class DHImageView: UIImageView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(_ frame: CGRect, style: DHImageViewType) {
        self.init(frame: frame)
        imageViewStyle = style
    }
    
    var imageViewStyle: DHImageViewType? {
        didSet {
            guard let imageViewStyle = imageViewStyle else {
                return
            }
            
            if let padding = imageViewStyle.padding?.edgeInset {
                self.image = UIImage(named: "Placeholder")?.withAlignmentRectInsets(padding)
            }
            self.contentMode = .scaleAspectFill
            self.layer.cornerRadius = imageViewStyle.viewProperties?.edgeCornerRadius ?? 0
            self.isUserInteractionEnabled = false
            setViewStyle(imageViewStyle.viewProperties)
            
        }
    }
    
}
