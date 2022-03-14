//
//  BarGraph.swift
//  FitnessAppUI
//
//  Created by Scott Clampett on 3/14/22.
//

import SwiftUI

struct BarGraph: View {
    var steps: [Step]
    
    var body: some View {
        GraphView()
            .padding(.top,20)
    }
    
    //MARK: View Builders
    @ViewBuilder
    func GraphView()->some View {
        GeometryReader { proxy in
            ZStack {
                VStack(spacing: 0) {
                    ForEach(getGraphLines(), id: \.self) { line in
                        HStack(spacing: 8) {
                            Text("\(Int(line))")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(height: 20)
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 1)
                        }
                        .frame(maxHeight: .infinity,alignment: .bottom)
                        // Removing the text size...
                        .offset(y: -15)
                    }
                }
                
                HStack {
                    ForEach(steps.indices, id: \.self) { index in
                        let step = steps[index]

                        VStack {
                            VStack(spacing: 5) {
                                AnimatedBarGraph(step: steps[index], index: index)
                            }
                            .padding(.horizontal,5)
                            .frame(height: getBarHeight(point: step.value, size: proxy.size))
                            
                            Text(
                                step.key
                                    .replacingOccurrences(of: " AM", with: "")
                                    .replacingOccurrences(of: " PM", with: "")
                            )
                                .font(.caption)
                                .frame(height: 25,alignment: .bottom)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .padding(.leading,30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        // Fixed Height
        .frame(height: 190)
    }
    
    //MARK: Private Methods
    func getBarHeight(point: CGFloat,size: CGSize) -> CGFloat {
        let max = getMax()
        let height = (point / max) * (size.height - 37)
        
        return height
    }
    
    // getting Sample Graph Lines based on max Value...
    func getGraphLines() -> [CGFloat] {
        let max = getMax()
        var lines: [CGFloat] = []
        
        lines.append(max)
        
        for index in 1...4 {
            // dividing the max by 4 and iterating as index for graph lines...
            let progress = max / 4
            
            lines.append(max - (progress * CGFloat(index)))
        }
        
        return lines
    }
    
    func getMax() -> CGFloat {
        let max = steps.max { first, scnd in
            return scnd.value > first.value
        }?.value ?? 0
        
        return max
    }
}

//MARK: Animated Bar Graph
struct AnimatedBarGraph: View {
    var step: Step
    var index: Int
    
    @State var showBar: Bool = false
    
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(step.color)
                .frame(height: showBar ? nil : 0, alignment: .bottom)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8).delay(Double(index) * 0.1)) {
                    showBar = true
                }
            }
        }
    }
}

struct BarGraph_Previews: PreviewProvider {
    static var previews: some View {
        FitnessGraphView()
    }
}
