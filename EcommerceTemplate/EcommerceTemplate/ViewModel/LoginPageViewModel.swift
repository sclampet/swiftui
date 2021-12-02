//
//  LoginPageViewModel.swift
//  EcommerceTemplate
//
//  Created by Scott Clampet on 12/2/21.
//

import SwiftUI

class LoginPageViewModel: ObservableObject {
    // Login Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    //Register
    @Published var registerUser: Bool = false
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword: Bool = false
    
    
    func Login() {
        
    }
    
    func Register() {
        
    }
    
    func ForgotPassword() {
        
    }
}
