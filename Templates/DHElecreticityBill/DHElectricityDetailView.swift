//
//  DHElectricityDetailView.swift
//  DailyHub
//
//  Created by Karthi on 09/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import SwiftUI

struct DHUnitLabel: View {
    var body: some View {
        VStack(alignment: .center, spacing: 30, content: {
         DHText(textType: dhStyles.text!, text: "Km/L")
        DHText(textType: dhStyles.text!, text: "/ Km")
              })
    }
}

struct DHElectricityDetailView: View {
   @Binding var isActive: Bool
    var billDetails: [DHBillDetails]
    var showUnitLabel: Bool
    var body: some View {
        HStack {
                VStack(alignment: .leading, spacing: 30, content: {
                    ForEach(0 ..< billDetails.count) { billDetail in
                        DHText(textType: dhStyles.text!, text: self.billDetails[billDetail].billCatergory ?? "")
                    }
        })
            VStack(alignment: .center, spacing: 30, content: {
                ForEach(0 ..< billDetails.count) { billDetail in
                    DHText(textType: dhStyles.text!, text: ":")
                }
            })
           VStack(alignment: .center, spacing: 30, content: {
                ForEach(0 ..< billDetails.count) { billDetail in
                    DHText(textType: dhStyles.text!, text: self.billDetails[billDetail].billValue ?? "")
                }
           }).padding(.leading, 20)
            if self.showUnitLabel {
                DHUnitLabel()
            }
        }
            
        .navigationBarItems(leading: Button(action: { self.isActive = false }, label: { Text("< Back") })).navigationBarTitle("Bill Details", displayMode: .inline)
    }
}

