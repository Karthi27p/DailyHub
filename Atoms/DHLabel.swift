//
//  DHLabel.swift
//  DailyHub
//
//  Created by Karthi on 23/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import UIKit

class DHLabel: UILabel {
    
    //MARK: Initialization
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(_ frame: CGRect, style: DHLabelType) {
        self.init(frame: frame)
        labelType = style
    }
    
    //MARK: Label Configuration
    override func drawText(in rect: CGRect) {
        let edgeInset = contentEdgeInset
        super.drawText(in: rect.inset(by: edgeInset))
    }

    override var intrinsicContentSize: CGSize {
        let edgeInset = contentEdgeInset
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + edgeInset.left + edgeInset.right,
                      height: size.height + edgeInset.top + edgeInset.bottom)
    }
    
    var labelType: DHLabelType? {
        didSet {
            guard let textStyle = labelType else {
                return
            }
            
            self.numberOfLines = textStyle.numberOfLines ?? 1
            self.clipsToBounds = true
            self.layer.cornerRadius = labelType?.viewProperties?.edgeCornerRadius ?? 0
            setTextStyle(textStyle.textProperties)
            setViewStyle(textStyle.viewProperties)
        }
    }
    
    var contentEdgeInset: UIEdgeInsets {
        guard let padding = labelType?.padding?.edgeInset else {
            return UIEdgeInsets.zero
        }
        
        return padding
    }
    
}
