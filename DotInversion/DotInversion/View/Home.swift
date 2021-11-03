//
//  Home.swift
//  DotInversion
//
//  Created by Scott Clampet on 11/2/21.
//

import SwiftUI

struct Home: View {
    @State var dotState: DotState = .normal
    @State var dotScale: CGFloat = 1
    @State var dotRotation: Double = 0
    @State var isAnimating = false
    
    var body: some View {
        ZStack {
            ZStack {
                dotState == .normal ? Color("Gold") : Color("Grey")
                
                if dotState == .normal {
                    ExpandedView()
                } else {
                    MinimizedView()
                }
            }
            .animation(.none, value: dotState)
            
            Rectangle()
                .fill(dotState != .normal ? Color("Gold") : Color("Grey"))
                .overlay(
                    ZStack {
                        if dotState != .normal {
                            ExpandedView()
                        } else {
                            MinimizedView()
                        }
                    }
                )
                .animation(.none, value: dotState)
                // Masking the view with circle to create dot inversion animation...
                .mask {
                    GeometryReader { proxy in
                        Circle()
                            //while increasing the scale the content will be visible...
                            .frame(width: 100, height: 100)
                            .scaleEffect(dotScale)
                            .rotation3DEffect(.init(degrees: dotRotation), axis: (x: 0, y: 1, z: 0), anchorZ: dotState == .flipped ? -10 : 10, perspective: 1)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                            .offset(y: -60)
                    }
                }
            
            //Tap gesture
            Circle()
                .foregroundColor(.black.opacity(0.01))
                .frame(width: 100, height: 100)
                .overlay(
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .foregroundColor(dotState == .normal ? .white : .black)
                        .opacity(isAnimating ? 0 : 1)
                        .animation(.easeInOut(duration: 0.4), value: isAnimating)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .onTapGesture(perform: {
                    if isAnimating { return }
                    
                    isAnimating = true
                    
                    switch dotState {
                    case .normal:
                        //Half way to 1.5 seconds, reset the scale to 1
                        //This will give it that dot inversion effect...
                        //Where it shrinks back down to its original scale
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.725) {
                            withAnimation(.linear(duration: 0.7)) {
                                dotScale = 1
                                dotState = .flipped
                            }
                        }
                        
                        withAnimation(.linear(duration: 1.5)) {
                            dotRotation = -180
                            dotScale = 8
                        }
                    case .flipped:
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.725) {
                            withAnimation(.linear(duration: 0.7)) {
                                dotScale = 1
                                dotState = .normal
                            }
                        }
                        
                        withAnimation(.linear(duration: 1.5)) {
                            dotScale = 8
                            dotRotation = 0
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                       isAnimating = false
                    }
                })
                .offset(y: -60)
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func ExpandedView() -> some View {
        VStack(spacing: 10) {
            Image(systemName: "ipad")
                .font(.system(size: 145))
            Text("iPad")
                .font(.system(size: 38).bold())
        }
        .foregroundColor(.white)
    }
    
    @ViewBuilder
    func MinimizedView() -> some View {
        VStack(spacing: 10) {
            Image(systemName: "applewatch")
                .font(.system(size: 145))
            Text("Apple Watch")
                .font(.system(size: 38).bold())
        }
        .foregroundColor(.white)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

enum DotState {
    case normal
    case flipped
}
