//
//  ChatController.swift
//  messenger
//
//  Created by Scott Clampet on 7/10/19.
//  Copyright © 2019 sc. All rights reserved.
//

import SwiftUI
import Combine

// ChatController needs to be a BindableObject in order
// to be accessible by SwiftUI
class ChatController: BindableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    var messages = [
        ChatMessage(message: "Oh hey there!", avatar: "A", color: .red),
        ChatMessage(message: "lol Great to hear from you!", avatar: "B", color: .blue)
    ]
    
    // this function will be accessible from SwiftUI main view
    // here you can add the necessary code to send your messages not only to the SwiftUI view, but also to the database so that other users of the app would be able to see it
    func sendMessage(_ chatMessage: ChatMessage) {
        // here we populate the messages array
        messages.append(chatMessage)
        // here we let the SwiftUI know that we need to rebuild the views
        didChange.send(())
    }
}

