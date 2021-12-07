//
//  SearchView.swift
//  EcommerceTemplate
//
//  Created by Scott Clampet on 12/4/21.
//

import SwiftUI

struct SearchView: View {
    var animation: Namespace.ID
    
    @EnvironmentObject var homeData: HomeViewModel
    @EnvironmentObject var sharedData: SharedDataViewModel
    
    //Activating Text Field with the help of FocusState
    @FocusState var startTF: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: Search Bar
            HStack(spacing: 20) {
                // MARK: Close Button
                Button {
                    withAnimation {
                        homeData.searchActivated = false
                    }
                    
                    homeData.searchText = ""
                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black.opacity(0.7))
                }

                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    TextField("Search", text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background (Capsule().strokeBorder(Color("Purple"), lineWidth: 1.5))
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 10)
            
            //Show Progress if searching
            //else show no results if found nothing
            if let products = homeData.searchedProducts {
                if products.isEmpty {
                    //MARK: No Results Found
                    VStack(spacing: 0) {
                        Image("NotFound")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 60)
                        
                        Text("Item Not Found")
                            .font(.custom(customFont, size: 22).bold())
                        
                        Text("Try a more generic search term or try looking for alternative products.")
                            .font(.custom(customFont, size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                    .padding()
                } else {
                    //MARK: Filter Found Results
                    ScrollView(.vertical, showsIndicators: false) {
                        //MARK: Staggered Grid
                        VStack(spacing: 0) {
                            StaggeredGrid(columns: 2, spacing: 20, list: products) { product in
                                ProductCardView(product: product)
                            }
                            .padding()
                        }
                    }
                }
            } else {
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("HomeBG"))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
    }
    
    func ProductCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            ZStack {
                if sharedData.showDetailProduct {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                } else {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
                .offset(y: -50)
                .padding(.bottom, -50)
            
            Text(product.title)
                .font(.custom(customFont, size: 18))
                .foregroundColor(.black)
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
        .padding(.top, 50)
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.detailProduct = product
                sharedData.fromSearchPage = true
                sharedData.showDetailProduct = true
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
