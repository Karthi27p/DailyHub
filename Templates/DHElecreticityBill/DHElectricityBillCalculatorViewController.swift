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
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
