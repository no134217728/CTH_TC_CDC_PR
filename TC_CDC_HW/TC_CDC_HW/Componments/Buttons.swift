//
//  Buttons.swift
//  TC_CDC_HW
//
//  Created by tpi on 2025/3/18.
//

import SwiftUI

struct MenuButton: View {
    let iconName: String
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(iconName)
            Text(title)
                .font(.system(size: 14))
                .foregroundStyle(cubeGray7)
                .frame(width: 109 ,height: 24.0)
        }
    }
}

struct FavoriteButton: View {
    let iconType: FavoriteType
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            switch iconType {
            case .CUBC:
                Image("button00ElementScrollTree")
            case .Mobile:
                Image("button00ElementScrollMobile")
            case .PMF:
                Image("button00ElementScrollBuilding")
            case .CreditCard:
                Image("button00ElementScrollCreditCard")
            }
            Text(title)
                .font(.system(size: 12))
                .foregroundStyle(cubeGray6)
                .frame(width: 72 ,height: 24.0)
        }.frame(width: 80, height: 80)
    }
}

struct BottomIcon: View {
    var selected: Bool
    
    let imageName: String
    let text: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(imageName)
                .frame(width: 24, height: 24)
            Text(text)
                .font(.system(size: 12))
                .foregroundStyle(selected ? orange01 : cubeGray7)
                .frame(width: 70, height: 16)
        }
    }
}

struct ServiceIcon: View {
    var body: some View {
        ZStack() {
            Text("Service")
                .font(.system(size: 12))
                .foregroundStyle(cubeGray7)
                .multilineTextAlignment(.center)
                .frame(width: 70, height: 16.0, alignment: .center)
                .offset(x: 0.0, y: 12.0)
            ZStack() {
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(width: 24.0, height: 24.0)
                ZStack() {
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(width: 10.6, height: 8.8)
                        .background(.gray)
                        .offset(x: 5.4, y: -0.3)
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(width: 5.9, height: 5.9)
                        .background(.gray)
                        .offset(x: 4.7, y: -7.0)
                    ZStack() {
                        Rectangle()
                            .foregroundStyle(.clear)
                            .frame(width: 13.7, height: 10.7)
                            .offset(x: 0.0, y: 0.0)
                        Rectangle()
                            .foregroundStyle(.clear)
                            .frame(width: 13.7, height: 10.7)
                            .background(.gray)
                            .offset(x: 0.0, y: 0.0)
                    }
                    .frame(width: 13.7, height: 10.7)
                    .offset(x: -3.8, y: 4.6)
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(width: 7.2, height: 7.2)
                        .background(.gray)
                        .offset(x: -4.1, y: -3.6)
                }
                .frame(width: 21.3, height: 19.9)
                .offset(x: -0.3, y: -0.0)
            }
            .frame(width: 24.0, height: 24.0)
            .offset(x: -0.5, y: -8.0)
        }
        .frame(width: 70.0, height: 40.0)
    }
}

#Preview {
    ServiceIcon()
}
