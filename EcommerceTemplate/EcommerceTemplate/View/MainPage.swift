//
//  MainPage.swift
//  EcommerceTemplate
//
//  Created by Scott Clampet on 12/2/21.
//

import SwiftUI

struct MainPage: View {
    @State var currentTab: Tab = .Home
    
    @StateObject var sharedData: SharedDataViewModel = SharedDataViewModel()
    
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Home(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.Home)
                
                Text("Liked")
                    .tag(Tab.Liked)
                
                ProfilePage()
                    .tag(Tab.Profile)
                
                Text("Cart")
                    .tag(Tab.Cart)
            }
            
            //MARK: Custom Tab Bar
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button {
                        currentTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color("Purple")
                                    .opacity(0.05)
                                    .cornerRadius(5)
                                    .blur(radius: 5)
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .foregroundColor(currentTab == tab ? Color("Purple") : .black.opacity(0.3))
                    }
                    .padding([.horizontal, .bottom])
                    .padding(.bottom, 10)
                }
            }
            .padding(.top, 20)
        }
        .background(Color("HomeBG").ignoresSafeArea())
        .overlay(
            //MARK: Product Details Overlay
            ZStack {
                if let product = sharedData.detailProduct, sharedData.showDetailProduct {
                    ProductDetailView(product: product, animation: animation)
                        .environmentObject(sharedData)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

enum Tab: String, CaseIterable {
    case Home = "Home"
    case Liked = "Liked"
    case Profile = "Profile"
    case Cart = "Cart"
}
