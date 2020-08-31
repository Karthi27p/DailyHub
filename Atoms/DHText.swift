//
//  DHText.swift
//  DailyHub
//
//  Created by Karthi on 09/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import SwiftUI

struct DHText: View {
    @State var textType: DHTextType
    @State var text: String
    
    private var textProperties: DHTextProperties {
        textType.textProperties!
    }
    
    private var foregroundColor: Color {
        (textProperties.textColor != nil) ? Color(hex: textProperties.textColor!) : Color.black
    }
    
    private var textWeight: Font.Weight {
        textProperties.isBold ?? false ? .bold : .regular
    }
    
    var body: some View {
        Group {
            Text(text).foregroundColor(foregroundColor).font(.system(size: textProperties.fontSize!, weight: textWeight, design: .default))
        }
    }
    
    
}
