//
//  DHElcetricityView.swift
//  DailyHub
//
//  Created by Karthi on 19/07/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import SwiftUI
import Combine

struct Background<Content: View>: View {
    private var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Color.white
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .overlay(content)
    }
}

struct DHElectricityView: View {
    
    
    @State private var previousReading = ""
    @State private var currentReading = ""
    @State private var defaultIndex = 0
    @State private var isActive = false
    @State private var billDetailsResult = [DHBillDetails()]
    @State private var fuelBillDetailsResult = [DHBillDetails()]
    
    @State private var fuelQuantity = ""
    @State private var fuelPrice = ""
    
    private var availableTypes = ["Domestic EB Bill", "Fuel Mileage"]
    
    
    @ObservedObject var loadTarrifData = DHElectricityBillViewModel()
    
    
    var body: some View {
        NavigationView{
            Background {
                VStack {
                    VStack(alignment: .leading, spacing: 20.0) {
                        Picker(selection: self.$defaultIndex, label: Text("")) {
                            ForEach(0 ..< self.availableTypes.count) {
                                Text(self.availableTypes[$0])
                            }
                        }.padding(.top, 15).pickerStyle(SegmentedPickerStyle()).onReceive([self.defaultIndex].publisher.first()) { _ in
                            self.clearText()
                        }
                        DHFormField(placeholder: "Enter previous reading", text: "PREVIOUS READING", textFieldValue: self.$previousReading)
                        DHFormField(placeholder: "Enter current reading", text: "CURRENT READING", textFieldValue: self.$currentReading)
                        if (self.defaultIndex == 1) {
                            DHFuelMileageView(fuelQuantity: self.$fuelQuantity, fuelPrice: self.$fuelPrice)
                        }
                        HStack {
                            Button(action: {
                                self.clearText()
                            }) {Text("Clear").font(.headline).padding(.leading, UIScreen.main.bounds.size.width/2 - 100).padding(.top, 20)
                                
                            }
                            
                            NavigationLink(destination: DHElectricityDetailView(isActive: self.$isActive, billDetails: self.defaultIndex == 0 ? self.billDetailsResult : self.fuelBillDetailsResult, showUnitLabel: self.defaultIndex == 1), isActive: self.$isActive) {
                                Text("Calculate").font(.headline).padding(.leading, 50).padding(.top, 20)
                            }.simultaneousGesture(TapGesture().onEnded{
                                if (self.defaultIndex == 0) {
                                    self.billDetailsResult = self.calculateReading()
                                } else {
                                    self.fuelBillDetailsResult = self.calculateFuelMileage()
                                    
                                }
                                
                            })
                        }
                        Spacer()
                    }
                    
                }.padding(.horizontal, 15)
            }.padding(.top, 180).keyboardadaptive().onTapGesture {
                self.hideKeyboard()
            }
            .navigationBarTitle("Bill Calculator", displayMode: .inline)
        }
    }
    
    // Clear label text
    func clearText() {
        self.previousReading = ""
        self.currentReading = ""
        self.fuelQuantity = ""
        self.fuelPrice = ""
        self.hideKeyboard()
    }
    
    // Calculate reading results
    func calculateReading() -> [DHBillDetails] {
        
        self.hideKeyboard()
        let currentValue: Float = Float(self.currentReading) ?? 0.0
        let previousValue: Float = Float(self.previousReading) ?? 0.0
        let unitsConsumed = currentValue - previousValue > 0 ? currentValue - previousValue : 0.0
        let currentSlabPossiblities = self.loadTarrifData.tarrifData?.biMonthlyConsumption.filter { item in
            return Int(unitsConsumed) <= item.maxLimit
        }
        var currentSlab: DHBiMonthlyConsumption?
        if (currentSlabPossiblities?.count == 0) {
            currentSlab = self.loadTarrifData.tarrifData?.biMonthlyConsumption.last!
        } else {
            currentSlab = currentSlabPossiblities?.first!
        }
        
        var unitsAdded: Float = 0.0
        var subsidyUnits: Float = 0.0
        var costIncurred: Float = 0.0
        var result: Float = 0.0
        if (unitsConsumed >= Float(self.loadTarrifData.tarrifData!.cutOffLimit!)) {
            for (_, value) in (currentSlab?.splitRate.enumerated())! {
                           if (value.chargePerUnit == 0) {
                               subsidyUnits += value.unit!
                           }
                if(value.unit! != Float(self.loadTarrifData.tarrifData!.cutOffLimit!)) {
                    unitsAdded += value.unit!
                                       costIncurred += value.unit! * value.chargePerUnit!
                                       result = costIncurred
                } else {
                    let remainingUnits = unitsConsumed - unitsAdded
                    costIncurred += remainingUnits * value.chargePerUnit!
                    result = costIncurred
                }
            }
        } else {
            for (index, value) in (currentSlab?.splitRate.enumerated())! {
                if (value.chargePerUnit == 0) {
                    subsidyUnits += value.unit!
                }
                if (unitsAdded < unitsConsumed) {
                    unitsAdded += value.unit!
                    costIncurred += value.unit! * value.chargePerUnit!
                    result = costIncurred
                } else if (unitsAdded > unitsConsumed) {
                    costIncurred -= (unitsAdded - unitsConsumed) * currentSlab!.splitRate[index - 1].chargePerUnit!
                    result = costIncurred
                } else {
                    result = costIncurred
                }
            }
            if (unitsAdded > unitsConsumed) {
                costIncurred -= (unitsAdded - unitsConsumed) * currentSlab!.splitRate[currentSlab!.splitRate.count - 1].chargePerUnit!
                result = costIncurred
            }
        }
        
        result = result + currentSlab!.fixedCharges
        return [
            DHBillDetails(billCatergory: "Service Type", billValue: self.loadTarrifData.tarrifData?.type),
            DHBillDetails(billCatergory: "Consumed Units", billValue: String(unitsConsumed)),
            DHBillDetails(billCatergory: "Subsidy Units", billValue: String(subsidyUnits)),
            DHBillDetails(billCatergory: "Current Charges ₹", billValue: String(format: "%.2f", result-currentSlab!.fixedCharges)),
            DHBillDetails(billCatergory: "Fixed Charges ₹", billValue: String(format: "%.2f", currentSlab!.fixedCharges)),
            DHBillDetails(billCatergory: "Net Amount ₹", billValue: String(format: "%.2f" , result))]
    }
    
    // Calculate mileage
    func calculateFuelMileage() -> [DHBillDetails] {
        self.hideKeyboard()
        let currentValue: Float = Float(self.currentReading) ?? 0.0
        let previousValue: Float = Float(self.previousReading) ?? 0.0
        let fuelQuantity: Float = Float(self.fuelQuantity) ?? 0.0
        let fuelPrice: Float = Float(self.fuelPrice) ?? 0.0
        let unitsConsumed = currentValue - previousValue > 0 ? currentValue - previousValue : 0.0
        let mileage = unitsConsumed/fuelQuantity > 0 ? unitsConsumed/fuelQuantity : 0.0
        let cost = fuelPrice/unitsConsumed > 0 ? fuelPrice/unitsConsumed : 0.0
        return [DHBillDetails(billCatergory: "Fuel Mileage", billValue: String(format: "%.2f", mileage)), DHBillDetails(billCatergory: "Cost Mileage ₹", billValue: String(format:"%.2f" ,cost))]
    }
    
}

struct DHElcetricityView_Previews: PreviewProvider {
    static var previews: some View {
        DHElectricityView()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
