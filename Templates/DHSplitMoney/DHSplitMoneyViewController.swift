//
//  DHSplitMoneyViewController.swift
//  DailyHub
//
//  Created by Karthi on 27/06/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import UIKit
import SwiftUI

class DHSplitMoneyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let splitMoneyView: some View = DHSplitMoneyView()
        let hostingViewController = UIHostingController(rootView: splitMoneyView)
        guard let hostView = hostingViewController.view else {
            return
        }
        hostView.frame = view.frame
        view.addSubview(hostView)
        self.addChild(hostingViewController)
        hostingViewController.didMove(toParent: self)
    }
}
