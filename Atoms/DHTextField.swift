//
//  DHTextField.swift
//  DailyHub
//
//  Created by Karthi on 03/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import SwiftUI

struct DHTextField: View {
    @State var textFieldType: DHTextFieldType
    @Binding var text: String
    @State var placeholder: String?
    
    private var textProperties: DHTextProperties {
        textFieldType.textProperties!
    }
    
    private var viewProperties: DHViewProperties {
        textFieldType.viewProperties!
    }
    
    private var backgroundColor: Color {
        (viewProperties.bgColor != nil) ? Color(hex: viewProperties.bgColor!) : Color.clear
    }
    
    var body: some View {
        Group {
            TextField(placeholder ?? "", text: $text ).font(.headline).padding((textFieldType.padding?.edgeInset)!).keyboardType(.decimalPad).background(backgroundColor).cornerRadius(textFieldType.viewProperties?.edgeCornerRadius ?? 0)
            
        }
    }
    
    
}
