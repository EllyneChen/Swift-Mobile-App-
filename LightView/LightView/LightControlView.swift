//
//  LightControlView.swift
//  LightView
//
//  Created by Student1 on 15/09/2026.
//

import SwiftUI

struct LightControlView: View {
    
    @Binding var isLightOn: Bool
    
    var body: some View {
        Button("Toggle Light") {
            isLightOn.toggle()
        }
    }
}



