//
//  DHElectricityBillCalculatorViewController.swift
//  DailyHub
//
//  Created by Karthi on 28/06/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import UIKit
import SwiftUI

class DHElectricityBillCalculatorViewController: UIViewController {
    
    var electricityTarrifModel: DHElectricityTarrifModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let electricityView: some View = DHElectricityView()
        let hostingViewController = UIHostingController(rootView: electricityView)
        guard let hostView = hostingViewController.view else {
            return
        }
        hostView.frame = view.frame
        view.addSubview(hostView)
        self.addChild(hostingViewController)
        hostingViewController.didMove(toParent: self)
    }
}
