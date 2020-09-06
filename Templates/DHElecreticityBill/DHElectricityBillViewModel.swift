//
//  DHElectricityBillViewModel.swift
//  DailyHub
//
//  Created by Karthi on 28/06/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import UIKit
import Foundation
import Combine

/* class DHElectricityBillViewModel: NSObject {

    func fetchTarrifData() -> DHElectricityTarrifModel {
        if let url = Bundle.main.url(forResource: "Tarrif", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedJson = try JSONDecoder().decode(DHElectricityTarrifModel.self, from: data)
                return decodedJson
            } catch {
                print("ERROR IN FETCHING FROM BUNDLE", error)
            }
        }
        return DHElectricityTarrifModel(status: nil, totalResults: nil, type: nil, cutOffLimit: nil, biMonthlyConsumption: [])
    }
} */

class  DHElectricityBillViewModel: ObservableObject {
    @Published var tarrifData: DHElectricityTarrifModel?
    
    init() {
        DHApiService.fetchDataFromBundle(resourceName: "Tarrif", resultStruct: DHElectricityTarrifModel.self) { [weak self] (data, error) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.tarrifData = data as? DHElectricityTarrifModel
    }
  }
}
