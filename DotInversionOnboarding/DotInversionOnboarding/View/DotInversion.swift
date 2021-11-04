//
//  DotInversion.swift
//  DotInversionOnboarding
//
//  Created by Scott Clampet on 11/3/21.
//

import SwiftUI

struct DotInversion: View {
    @State var dotState: DotState = .normal
    @State var dotScale: CGFloat = 1
    @State var dotRotation: Double = 0
    @State var isAnimating = false
    @Binding var currIndex: Int {
        didSet {
            print("currIndex set")
        }
    }
    @State var nextIndex: Int = 1 {
        didSet {
            print("nextIndex set \(nextIndex)")
        }
    }
    
    var body: some View {
        ZStack {
            ZStack {
                dotState == .normal ? tabs[currIndex].color : tabs[nextIndex].color
                
                if dotState == .normal {
                    ExpandedView()
                } else {
                    MinimizedView()
                }
            }
            .animation(.none, value: dotState)
            
            Rectangle()
                .fill(dotState != .normal ? tabs[currIndex].color : tabs[nextIndex].color)
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
                            .frame(width: 80, height: 80)
                            .scaleEffect(dotScale)
                            .rotation3DEffect(.init(degrees: dotRotation), axis: (x: 0, y: 1, z: 0), anchorZ: dotState == .flipped ? -10 : 10, perspective: 1)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                            .offset(y: -(getSafeArea().bottom + 20))
                    }
                }
            
            //Tap gesture
            Circle()
                .foregroundColor(.black.opacity(0.01))
                .frame(width: 80, height: 80)
                .overlay(
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .foregroundColor(.white)
                        .opacity(dotRotation == -180 ? 0 : 1)
                        .animation(.easeInOut, value: dotRotation)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .onTapGesture(perform: {
                    if isAnimating { return }
                    
                    isAnimating = true
                    
                    withAnimation(.linear(duration: 1.5)) {
                        dotRotation = -180
                        dotScale = 8
                    }
                    
                    //Half way to 1.5 seconds, reset the scale to 1
                    //This will give it that dot inversion effect...
                    //Where it shrinks back down to its original scale
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.74) {
                        withAnimation(.easeInOut(duration: 0.69)) {
                            dotState = .flipped
                        }
                    }
                    
                    //reversing with a little speed
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            dotScale = 1
                        }
                    }
                    
                    //reset animation state after 1.3sec
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                        //resetting to default
                        withAnimation(.easeInOut(duration: 0.3)) {
                            dotRotation = 0
                            dotState = .normal
                            currIndex = nextIndex
                            nextIndex = getNextIndex()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isAnimating = false
                        }
                    }
                })
                .offset(y: -(getSafeArea().bottom + 20))
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func IntroView(tab: Tab) -> some View {
        VStack {
            Image(systemName: "\(tab.image)")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .foregroundColor(.white)
                .padding(40)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(tab.title)
                    .font(.system(size: 40))
                Text(tab.subTitle)
                    .font(.system(size: 50, weight: .bold))
                Text(tab.description)
                    .fontWeight(.semibold)
                    .padding(.top)
                    .frame(width: getRect().width - 100, alignment: .leading)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding([.trailing, .top])
        }
    }
    
    func getNextIndex() -> Int {
        print(nextIndex)
        return (nextIndex + 1) > (tabs.count - 1) ? 0 : (nextIndex + 1)
    }
    
    @ViewBuilder
    func ExpandedView() -> some View {
        IntroView(tab: tabs[currIndex])
            .offset(y: -75)
    }
    
    @ViewBuilder
    func MinimizedView() -> some View {
        IntroView(tab: tabs[nextIndex])
            .offset(y: -75)
    }
}

struct DotInversion_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 Pro Max")
    }
}

enum DotState {
    case normal
    case flipped
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}
