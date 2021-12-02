//
//  Home.swift
//  EcommerceTemplate
//
//  Created by Scott Clampet on 12/2/21.
//

import SwiftUI

struct Home: View {
    @Namespace var animation
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            //MARK: Search Bar
            VStack(spacing: 0) {
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    //Since
                    TextField("Search", text: .constant(""))
                        .disabled(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(.gray, lineWidth: 0.8)
                )
                .frame(width: getRect().width / 1.7)
                .padding(.horizontal, 25)
                
                Text("Order online\ncollect in store")
                    .font(.custom(customFont, size: 28).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                //MARK: Products Tabs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18) {
                        ForEach(ProductType.allCases, id: \.self) { type in
                            ProductTypeView(type: type)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 28)
                
                //MARK: Products Pages
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25) {
                        ForEach(homeData.filteredProducts, id: \.self){ product in
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom)
                    .padding(.top, 80)
                }
                .padding(.top, 30)
                
                //MARK: See More Button
                Button {
                    homeData.showMoreProducts.toggle()
                } label: {
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("see more")
                    }
                    .font(.custom(customFont, size: 15).bold())
                    .foregroundColor(Color("Purple"))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top, 10)

            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("HomeBG"))
        .onChange(of: homeData.productType) { _ in
            homeData.filterProductByType()
        }
        .sheet(isPresented: $homeData.showMoreProducts) {
            
        } content: {
            MoreProductsView()
        }

    }
    
    //MARK: @ViewBuilders
    @ViewBuilder
    func ProductTypeView(type: ProductType) -> some View {
        Button {
            withAnimation {
                homeData.productType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 16))
                .fontWeight(.semibold)
                .foregroundColor(homeData.productType == type ? Color("Purple") : .gray)
                .padding(.bottom, 10)
                .overlay(
                    ZStack {
                        if homeData.productType == type {
                            Capsule()
                                .fill(Color("Purple"))
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        } else {
                            Capsule()
                                .fill(.clear)
                                .frame(height: 2)
                        }
                    }
                        .padding(.horizontal, -5)
                    , alignment: .bottom
                )
        }

    }
    
    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
                .offset(y: -80)
                .padding(.bottom, -80)
            
            Text(product.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.custom(customFont, size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color("Purple"))
                .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white.cornerRadius(25)
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
