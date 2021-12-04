//
//  StaggeredGrid.swift
//  EcommerceTemplate
//
//  Created by Scott Clampet on 12/4/21.
//

import SwiftUI

struct StaggeredGrid<Content: View, T: Identifiable>: View where T: Hashable {
    var content: (T) -> Content
    var list: [T]
    var columns: Int
    var showsIndicators: Bool
    var spacing: CGFloat
    
    init(columns: Int, showsIndicators: Bool = false, spacing: CGFloat = 10, list: [T], @ViewBuilder content: @escaping(T) -> Content) {
        self.content = content
        self.list = list
        self.spacing = spacing
        self.showsIndicators = showsIndicators
        self.columns = columns
    }
    
    //MARK: Staggered Grid Function
    func setupList() -> [[T]] {
        //creating emtpy sub array of columns count
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        
        // spliting array for VStack oriented View
        var currIndex: Int = 0
        
        for object in list {
            gridArray[currIndex].append(object)
            
            currIndex = currIndex == (columns - 1) ? 0 : currIndex + 1
        }
        
        return gridArray
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            ForEach(setupList(), id: \.self) { columnsData in
                LazyVStack(spacing: spacing) {
                    ForEach(columnsData) { obj in
                        content(obj)
                    }
                }
                .padding(.top, getIndex(values: columnsData) == 1 ? 80 : 0)
            }
        }
        .padding(.vertical)
    }
    
    //Move second collumn down a bit
    func getIndex(values: [T]) -> Int {
        let index = setupList().firstIndex { t in
            return t == values
        } ?? 0
        
        return index
    }
}

struct StaggeredGrid_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
