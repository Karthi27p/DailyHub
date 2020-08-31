//
//  DHFormField.swift
//  DailyHub
//
//  Created by Karthi on 24/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import SwiftUI

struct DHFormField: View {
    @State var placeholder: String
    @State var text: String
    @Binding var textFieldValue: String
    
    
    var body: some View {
        Group {
            DHText(textType: dhStyles.text!, text: text)
            DHTextField(textFieldType: dhStyles.textField!, text: self.$textFieldValue, placeholder: placeholder)
        }
    }
    
    
}
