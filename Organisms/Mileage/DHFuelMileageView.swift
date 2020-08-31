//
//  DHFuelMileageView.swift
//  DailyHub
//
//  Created by Karthi on 24/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import SwiftUI

struct DHFuelMileageView: View {
    
    @Binding var fuelQuantity: String
    @Binding var fuelPrice: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            DHFormField(placeholder: "Enter fuel quantity", text: "FUEL QUANTITY", textFieldValue: self.$fuelQuantity)
            DHFormField(placeholder: "Enter total fuel price", text: "TOTAL FUEL PRICE", textFieldValue: self.$fuelPrice)
        }
        
    }
}
