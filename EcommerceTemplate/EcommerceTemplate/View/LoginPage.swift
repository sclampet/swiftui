//
//  LoginPage.swift
//  EcommerceTemplate
//
//  Created by Scott Clampet on 12/2/21.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageViewModel = LoginPageViewModel()
    
    var body: some View {
        VStack {
            //MARK: Welcome Back
            Text("Welcome\nBack")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.custom(customFont, size: 55).bold())
                .frame(height: getRect().height / 3.5)
                .padding()
                .background(
                    ZStack {
                        //MARK: Gradient Circle
                        LinearGradient(
                            colors: [Color("LoginCircle"),
                                     Color("LoginCircle").opacity(0.8),
                                     Color("Purple")],
                            startPoint: .top,
                            endPoint: .bottom)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(.trailing)
                            .offset(y: -25)
                            .ignoresSafeArea()
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 30, height: 30)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding(30)
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 23, height: 23)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(.leading, 30)
                    }
                )
            
            //MARK: Login Form
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    Text("Login")
                        .font(.custom(customFont, size: 22).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomTextField(icon: "envelope", title: "Email", hint: "jobin@gmail.com", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top, 30)
                    
                    CustomTextField(icon: "lock", title: "Password", hint: "1234578", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top, 10)
                    
                    //MARK: Register reenter password
                    if (loginData.registerUser) {
                        CustomTextField(icon: "lock", title: "Password", hint: "1234578", value: $loginData.reEnterPassword, showPassword: $loginData.showReEnterPassword)
                            .padding(.top, 10)
                    }
                    
                    //MARK: Forgot Password Button
                    Button {
                        loginData.ForgotPassword()
                    } label: {
                        Text("Forgot password?")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //MARK: Login button
                    Button {
                        if loginData.registerUser {
                            loginData.Register()
                        } else {
                            loginData.Login()
                        }
                    } label: {
                        Text(loginData.registerUser ? "Register" : "Login")
                            .font(.custom(customFont, size: 17).bold())
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("Purple"))
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.07), radius: 5, x: 5, y: 5)
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                    
                    //MARK: Register button
                    Button {
                        withAnimation {
                            loginData.registerUser.toggle()
                        }
                    } label: {
                        Text(loginData.registerUser ? "Login" : "Create account")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.top, 8)
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                //MARK: Custom corners
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Purple"))
        //Clear data when changing between login/register
        .onChange(of: loginData.registerUser) { newValue in
            loginData.password = ""
            loginData.reEnterPassword = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
        
    }
    
    //MARK: ViewBuilders
    @ViewBuilder
    func CustomTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue {
                SecureField(hint, text:value)
                    .padding(.top, 2)
            } else {
                TextField(hint, text:value)
                    .padding(.top, 2)
            }
            
            Divider()
                .background(.black.opacity(0.4))
        }
        
        //Show password button
        .overlay(
            Group {
                if title.contains("Password") {
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13).bold())
                            .foregroundColor(Color("Purple"))
                            .offset(y: 8)
                    })
                }
            }
            , alignment: .trailing
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
