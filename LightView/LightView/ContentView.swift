//
//  ContentView.swift
//  LightView
//
//  Created by Student1 on 15/09/2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLightOn = false
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(isLightOn ? "Light is On" : "Light is Off")
            LightControlView(isLightOn: $isLightOn)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
