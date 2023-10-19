//
//  ContentView.swift
//  CutonSheet
//
//  Created by Denis Yarets on 19/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showView: Bool = false
    
    var body: some View {
        
        ZStack {
            Button("toggle") {
                showView.toggle()
            }
            
            SheetView($showView)
        }
        
        // var body
    }
}

#Preview {
    ContentView()
}
