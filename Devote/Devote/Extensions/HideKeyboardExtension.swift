//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Scott Clampet on 10/1/21.
//

import SwiftUI

#if canImport(UIKit)

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

#endif
