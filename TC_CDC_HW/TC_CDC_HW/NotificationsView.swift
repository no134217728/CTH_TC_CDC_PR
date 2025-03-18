//
//  NotificationsView.swift
//  TC_CDC_HW
//
//  Created by tpi on 2025/3/12.
//

import SwiftUI

struct NotificationsView: View {
    @Binding var isOnNotificationsView: Bool
    
    @State var notificationList: [NotificationList.Message] = []
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Spacer(minLength: 15)
                    Button {
                        isOnNotificationsView = false
                    } label: {
                        Image("iconArrowWTailBack")
                    }
                    Spacer().frame(maxWidth: .infinity)
                }
                Text("Notification")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(cubeGray10)
                    .frame(height: 28)
            }.frame(height: 48)
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(notificationList.indices, id: \.self) { index in
                        MessageCell(message: notificationList[index])
                    }
                }
            }
        }
        .background(mainBackground)
        .navigationBarHidden(true)
    }
}

struct MessageCell: View {
    let message: NotificationList.Message
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                if message.status {
                    Spacer(minLength: 32)
                } else {
                    Spacer(minLength: 16)
                    Circle()
                        .frame(width: 12.0, height: 12.0)
                        .foregroundStyle(orange01)
                    Spacer(minLength: 4)
                }
                Text(message.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(cubeGray10)
                    .frame(maxWidth: .infinity, maxHeight: 24, alignment: .leading)
                Spacer(minLength: 32)
            }
            HStack {
                Spacer(minLength: 32)
                Text(message.updateDateTime)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(cubeGray10)
                    .frame(maxWidth: .infinity, maxHeight: 24, alignment: .leading)
                Spacer(minLength: 32)
            }
            HStack {
                Spacer(minLength: 32)
                Text(message.message)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(battleshipGrey)
                    .frame(maxWidth: .infinity, maxHeight: 48, alignment: .topLeading)
                    .lineLimit(2)
                Spacer(minLength: 32)
            }
        }.frame(height: 128)
    }
}

#Preview {
    NotificationsView(isOnNotificationsView: .constant(true),
                      notificationList: [])
}
