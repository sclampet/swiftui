//
//  MainPage.swift
//  EcommerceTemplate
//
//  Created by Scott Clampet on 12/2/21.
//

import SwiftUI

struct MainPage: View {
    @State var currentTab: Tab = .Home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Home()
                    .tag(Tab.Home)
                
                Text("Liked")
                    .tag(Tab.Liked)
                
                Text("Profile")
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
        }
        .background(Color("HomeBG").ignoresSafeArea())
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
