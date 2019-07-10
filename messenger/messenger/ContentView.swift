//
//  ContentView.swift
//  messenger
//
//  Created by Scott Clampet on 7/8/19.
//  Copyright © 2019 sc. All rights reserved.
//

//
//  ChatMessage.swift
//  messenger
//
//  Created by Scott Clampet on 7/8/19.
//  Copyright © 2019 sc. All rights reserved.
//

import SwiftUI

// let's create a structure that will represent each message in chat
struct ChatMessage : Hashable {
    var message: String
    var avatar: String
    var color: Color
    var isMe: Bool = false
}

struct ContentView : View {
    @State var composedMessage: String = ""
    @EnvironmentObject var chatController: ChatController
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Chat Room").font(.largeTitle).bold()
                Spacer()
            }.padding()
            List {
                ForEach(chatController.messages.identified(by: \.self)) {
                    ChatRow(chatMessage: $0)
                }
            }
            HStack {
                Group {
                    TextField($composedMessage, placeholder: Text("Message...")).frame(minHeight: 50).padding(.leading)
                }.border(Color.gray, width: 3, cornerRadius: 25).padding()
                Button(action: sendMessage) {
                    Text("Send").font(.title)
                }
                }
                .padding(.trailing)
                .frame(minHeight: 90)
            
            Rectangle().frame(height: 35)
            
        }.edgesIgnoringSafeArea(.bottom)
    }
    
    func sendMessage() {
        chatController.sendMessage(ChatMessage(message: composedMessage, avatar: "C", color: .green, isMe: true))
        composedMessage = ""
    }
}

struct ChatRow : View {
    var chatMessage: ChatMessage
    
    var body: some View {
        Group {
            if !chatMessage.isMe {
                HStack {
                    Text(chatMessage.avatar)
                    Text(chatMessage.message)
                        .bold()
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(chatMessage.color, cornerRadius: 10)
                    Spacer()
                }
            } else {
                HStack {
                    Spacer()
                    Text(chatMessage.message)
                        .bold()
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(chatMessage.color, cornerRadius: 10)
                    Text(chatMessage.avatar)
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ChatController())
    }
}
#endif

