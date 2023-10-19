//
//  SheetView.swift
//  CutonSheet
//
//  Created by Denis Yarets on 19/10/2023.
//

import SwiftUI

struct SheetView: View {
    
    @Binding var isCalled: Bool
    @State private var isPresented: Bool = false
    
    @State private var offset: CGFloat = 0
    @State private var opacity: CGFloat = 0
    
    let delay: Double = 0.35
    
    private var height: CGFloat {
        UIScreen.main.bounds.height / 2
    }
    
    init(_ isCalled: Binding<Bool>) {
        self._isCalled = isCalled
    }
    
    var body: some View {
        
        ZStack {
            if isPresented { /// put actula view inside this if statement
                ZStack(alignment: .bottom) {
                    Color.black.opacity(opacity)
                        .onTapGesture { isCalled.toggle() }
                    
                    ZStack(alignment: .top) {
                        LinearGradient(colors: [.blue, .black], startPoint: .bottom, endPoint: .top)
                        
                        VStack(spacing: 0) {
                            Capsule()
                                .frame(width: 100, height: 2)
                                .foregroundStyle(Color.white)
                                .padding(.vertical, 10)
                        }
                    }
                    .frame(height: height)
                    .offset(y: offset)
                    
                    Color.black.opacity(0.001)
                        .frame(height: 20)
                        .offset(y: -(height - 20))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    offset = max(0, gesture.translation.height)
                                }.onEnded { gesture in
                                    if gesture.translation.height > height * 0.2, gesture.predictedEndTranslation.height > height * 0.2 {
                                        isCalled.toggle()
                                    } else { appear() }
                                }
                        )
                }
                .ignoresSafeArea()
            }
        }
        .onAppear { disappear() }
        .onChange(of: isCalled) {
            if isCalled {
                isPresented = true
                appear()
            }
            else {
                disappear()
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) { isPresented = false }
            }
        }
        
        // var body
    }
    
    private func appear() {
        withAnimation(.easeInOut(duration: delay)) {
            opacity = 0.5
            offset = 0
        }
    }
    
    private func disappear() {
        withAnimation(.easeInOut(duration: delay)) {
            opacity = 0
            offset = height
        }
    }
    
}

#Preview {
    SheetView(.constant(true))
}
