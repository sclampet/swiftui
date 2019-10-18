//
//  ChatController.swift
//  messenger
//
//  Created by Scott Clampet on 7/10/19.
//  Copyright © 2019 sc. All rights reserved.
//

import SwiftUI
import Combine

// ChatController needs to be a ObservableObject in order
// to be accessible by SwiftUI

class ChatController : ObservableObject {
    // didChange will let the SwiftUI know that some changes have happened in this object
    // and we need to rebuild all the views related to that object
    var didChange = PassthroughSubject<Void, Never>()
    
    // We've relocated the messages from the main SwiftUI View. Now, if you wish, you can handle the networking part here and populate this array with any data from your database. If you do so, please share your code and let's build the first global open-source chat app in SwiftUI together
    @Published var messages = [
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
