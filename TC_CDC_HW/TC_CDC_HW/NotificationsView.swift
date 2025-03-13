//
//  NotificationsView.swift
//  TC_CDC_HW
//
//  Created by tpi on 2025/3/12.
//

import SwiftUI

struct NotificationsView: View {
    @Binding var isOnNotificationsView: Bool
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    NotificationsView(isOnNotificationsView: .constant(true))
}
