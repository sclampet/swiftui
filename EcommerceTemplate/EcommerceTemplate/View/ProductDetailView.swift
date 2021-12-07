//
//  ProductDetailView.swift
//  EcommerceTemplate
//
//  Created by Scott Clampet on 12/5/21.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    
    var animation: Namespace.ID
    
    @EnvironmentObject var sharedData: SharedDataViewModel
    
    var body: some View {
        VStack {
            //MARK: Title Bar and Product Image
            VStack {
                HStack {
                    Button {
                        withAnimation(.easeInOut) {
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.black.opacity(0.7))
                    }


                }
                .padding()
                
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            
            //MARK: Product Details
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    Text(product.title)
                        .font(.custom(customFont, size: 20).bold())
                    
                    Text(product.subtitle)
                        .font(.custom(customFont, size: 16))
                        .foregroundColor(.gray)
                    
                    Text("Get Apple TC+ free for a year")
                        .font(.custom(customFont, size: 16).bold())
                        .padding(.top)
                    
                    Text("Available when you purchase any new iPhone, iPad, iPod Touch, Mac or Apple TV, $4.99/month after free trial.")
                        .font(.custom(customFont, size: 15))
                        .foregroundColor(.gray)
                    
                    //MARK: Full Desc. Button
                    Button  {
                        
                    } label: {
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }
                        .font(.custom(customFont, size: 15).bold())
                        .foregroundColor(Color("Purple"))
                    }
                    
                    //MARK: Total
                    HStack {
                        Text("Total")
                            .font(.custom(customFont, size: 17))
                        
                        Spacer()
                        
                        Text("\(product.price)")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.top, 20)
                    
                    //MARK: Add Button
                    Button {
                        
                    } label: {
                        Text("add to basket")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color("Purple")
                                    .cornerRadius(15)
                                    .shadow(color: .black.opacity(0.06), radius: 5, x: 5, y: 5)
                            )
                    }


                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .background(Color("HomeBG"))
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        ProductDetailView(product: HomeViewModel().products[0])
//            .environmentObject(SharedDataViewModel())
        
        MainPage()
    }
}
