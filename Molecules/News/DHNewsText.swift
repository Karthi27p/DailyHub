//
//  DHNewsText.swift
//  DailyHub
//
//  Created by Karthi on 26/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class DHNewsText: UIView {
    
    @IBOutlet weak var titleLabel: DHLabel!
    @IBOutlet weak var descriptionLabel: DHLabel!
    
    private let nibName = "DHNewsText"
    
    //MARK: Initialization
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
    
    //MARK: Set Data and Styles
    // Set data to labels used in news cell
    var newsTextDataModel: DHNewsTextModel? {
        didSet {
            guard let dataModel = newsTextDataModel else {
                return
            }
            
            if let title = dataModel.title, !title.isEmpty {
                titleLabel.text = dataModel.title
            } else {
                titleLabel.isHidden = true
            }
            
            if let description = dataModel.description, !description.isEmpty {
                descriptionLabel.text = description
            } else {
                descriptionLabel.isHidden = true
            }
            
            titleLabel.text = dataModel.title ?? ""
            descriptionLabel.text = dataModel.description ?? ""
            configureStyle()
        }
    }
    
    // Set styles for the labels
    private var labelStyle: DHStyleLabel? {
        didSet {
            guard let labelStyle = labelStyle else {
                return
            }
            
            titleLabel.labelType = labelStyle.title
            descriptionLabel.labelType = labelStyle.description
        }
    }
    
    // Get label styles to be used
    private func configureStyle() {
        guard let styles = dhStyles, let labelStyles = styles.labels else {
            return
        }
        labelStyle = labelStyles
    }
    
}
