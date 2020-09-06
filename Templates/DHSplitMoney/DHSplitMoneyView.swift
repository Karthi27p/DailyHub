//
//  DHSplitMoneyView.swift
//  DailyHub
//
//  Created by Karthi on 27/06/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import SwiftUI

struct DHSplitMoneyView: View {
    @State private var totalAmount = ""
    @State private var persons = ""
    @State private var tipPercentage = 2
    
    var tipPercentages = [10, 15, 20, 25]
    
    var splitAmount: Double {
        let total = Double(totalAmount) ?? 0
        let tipPercent = Double(tipPercentages[tipPercentage])
        guard let totalPersons = Double(persons) else { return 0 }
        let tipAmount = total / 100 * tipPercent
        return (tipAmount + total)/totalPersons
        
    }
    
    var body: some View {
        NavigationView {
            Background {
            Form {
        Section {
            TextField("Enter Amount", text: self.$totalAmount).keyboardType(.decimalPad)
            TextField("Enter number of persons", text: self.$persons).keyboardType(.decimalPad)
            /* Picker("Select number of persons", selection: self.$persons) {

                    ForEach(2..<100) {
                        Text("\($0) Persons")
                    }

            } */
        }
            Section(header: Text("Select the tip percentage")) {
                Picker("Tip Percentage", selection: self.$tipPercentage) {
                    ForEach(0..<self.tipPercentages.count) {
                        Text("\(self.tipPercentages[$0]) %")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
                Section {
                    Text("₹\(self.splitAmount, specifier: "%.2f")")
                }
        }
           
            }.padding(.top, 170).keyboardadaptive().onTapGesture {
                self.hideKeyboard()
            }
            .navigationBarTitle("Split Money", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DHSplitMoneyView()
    }
}
