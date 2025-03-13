//
//  ContentView.swift
//  TC_CDC_HW
//
//  Created by tpi on 2025/3/12.
//

import SwiftUI

struct ContentView: View {
    @State var isOnNotificationsView: Bool = false
    
    @State private var bellImgName: String = "iconBell01Nomal"
    @State private var eyeImgName: String = "iconEye01On"
    @State private var currentPage = 0
    
    let items = Array(1...5)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    HStack {
                        Spacer(minLength: 24)
                        Image("avatar").clipShape(.circle)
                        Spacer().frame(maxWidth: .infinity)
                        NavigationLink(destination: NotificationsView(isOnNotificationsView: $isOnNotificationsView),
                                       isActive: $isOnNotificationsView) {
                            Image(bellImgName)
                        }.frame(width: 24, height: 24)
                        Spacer(minLength: 24)
                    }.frame(height: 48)
                    HStack {
                        Spacer(minLength: 24)
                        Text("My Account Balance")
                            .fontWeight(.heavy)
                            .font(.system(size: 18))
                            .foregroundColor(cubeGray5)
                            .frame(height: 24.0)
                        Button {
                            
                        } label: {
                            Image(eyeImgName)
                        }.frame(width: 24, height: 24)
                        Spacer().frame(maxWidth: .infinity)
                    }.frame(height: 48)
                    VStack(spacing: 0) {
                        HStack {
                            Spacer(minLength: 24)
                            Text("USD")
                                .font(.system(size: 16))
                                .foregroundColor(cubeGray7)
                                .frame(height: 24.0)
                            Spacer().frame(maxWidth: .infinity)
                        }
                        HStack {
                            Spacer(minLength: 24)
                            Text("12,345.67")
                                .font(.system(size: 24))
                                .foregroundColor(cubeGray8)
                                .frame(height: 32.0)
                            Spacer().frame(maxWidth: .infinity)
                        }
                    }.frame(height: 64)
                    VStack(spacing: 0) {
                        HStack {
                            Spacer(minLength: 24)
                            Text("KHR")
                                .font(.system(size: 16))
                                .foregroundColor(cubeGray7)
                                .frame(height: 24.0)
                            Spacer().frame(maxWidth: .infinity)
                        }
                        HStack {
                            Spacer(minLength: 24)
                            Text("12,345.67")
                                .font(.system(size: 24))
                                .foregroundColor(cubeGray8)
                                .frame(height: 32.0)
                            Spacer().frame(maxWidth: .infinity)
                        }
                    }.frame(height: 64)
                    Spacer(minLength: 8)
                    HStack(spacing: 0) {
                        Spacer()
                        MenuButton(iconName: "button00ElementMenuTransfer",
                                   title: "Transfer")
                        Spacer()
                        MenuButton(iconName: "button00ElementMenuPayment",
                                   title: "Payment")
                        Spacer()
                        MenuButton(iconName: "button00ElementMenuUtility",
                                   title: "Utility")
                        Spacer()
                    }.frame(height: 96)
                    HStack(spacing: 0) {
                        Spacer()
                        MenuButton(iconName: "button01Scan",
                                   title: "QR pay scan")
                        Spacer()
                        MenuButton(iconName: "button00ElementMenuQRcode",
                                   title: "My QR Code")
                        Spacer()
                        MenuButton(iconName: "button00ElementMenuTopUp",
                                   title: "Top up")
                        Spacer()
                    }.frame(height: 96)
                    Spacer(minLength: 8)
                    HStack(spacing: 0) {
                        Spacer(minLength: 24)
                        Text("My Favorite")
                            .fontWeight(.heavy)
                            .font(.system(size: 18))
                            .foregroundColor(cubeGray5)
                            .frame(height: 24.0)
                        Spacer().frame(maxWidth: .infinity)
                        Text("More")
                            .font(.system(size: 16))
                            .foregroundColor(cubeGray5)
                            .frame(height: 24.0)
                        Image("iconArrow01Next")
                        Spacer(minLength: 16)
                    }.frame(height: 48)
                    HStack(alignment: .top, spacing: 0) {
                        Spacer(minLength: 24)
                        VStack(spacing: 0) {
                            Image("button00ElementScrollEmpty 1")
                            Text("- - -")
                                .foregroundColor(cubeGray6)
                                .font(.system(size: 12))
                                .frame(height: 24)
                        }.frame(width: 80, height: 80)
                        Text("You can add a favorite through the transfer or payment function.")
                            .font(.system(size: 14))
                            .foregroundColor(cubeGray6)
                            .alignmentGuide(.top) { _ in
                                -12
                            }
                        Spacer(minLength: 24)
                    }.frame(height: 88)
                    Spacer(minLength: 16)
                    VStack {
                        Spacer(minLength: 4)
                        TabView(selection: $currentPage) {
                            ForEach(items, id: \.self) { item in
                                BannerView(imageUrl: "\(item)").tag(item)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        Spacer(minLength: 4)
                    }
                    .frame(height: 96)
                    PageControl(currentPage: $currentPage, totalPages: items.count)
                        .frame(height: 20)
                    HStack {
                        Spacer(minLength: 24)
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 327.0, height: 50.0)
                                .background(Color(white: 1.0))
                                .cornerRadius(41.5)
                                .shadow(color: Color(white: 0.0, opacity: 0.12), radius: 8.0, x: 0.0, y: 4.0)
                            HStack {
                                BottomIcon(selected: true, imageName: "icTabbarHomeActive", text: "Home")
                                BottomIcon(selected: false, imageName: "icTabbarAccountDefault", text: "Account")
                                BottomIcon(selected: false, imageName: "icTabbarLocationActive", text: "Location")
                                ServiceIcon()
                            }
                        }
                        Spacer(minLength: 24)
                    }.frame(height: 50)
                    Spacer(minLength: 22)
                }
            }
            .navigationBarHidden(true)
            .background(mainBackground)
        }.navigationViewStyle(.stack)
    }
}

struct MenuButton: View {
    let iconName: String
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(iconName)
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(cubeGray7)
                .frame(width: 109 ,height: 24.0)
        }
    }
}

struct BannerView: View {
    let imageUrl: String
    
    var body: some View {
        HStack {
            Spacer(minLength: 24)
            AsyncImage(url: URL(string: "https://willywu0201.github.io/data/banner\(imageUrl).jpg")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable().scaledToFit().cornerRadius(12)
                case .failure(let error):
                    Text("\(error)")
                @unknown default:
                    Text("@unknown")
                }
            }
            Spacer(minLength: 24)
        }
    }
}

struct PageControl: View {
    @Binding var currentPage: Int
    
    let totalPages: Int

    var body: some View {
        HStack {
            ForEach(0..<totalPages, id: \.self) { index in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(currentPage == index ? .black : grayDot)
                    .padding(3)
            }
        }
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
                .foregroundColor(selected ? orange01 : cubeGray7)
                .frame(width: 70, height: 16)
        }
    }
}

struct ServiceIcon: View {
    var body: some View {
        ZStack() {
            Text("Service")
                .font(.system(size: 12))
                .foregroundColor(cubeGray7)
                .multilineTextAlignment(.center)
                .frame(width: 70, height: 16.0, alignment: .center)
                .offset(x: 0.0, y: 12.0)
            ZStack() {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 24.0, height: 24.0)
                ZStack() {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 10.6, height: 8.8)
                        .background(.gray)
                        .offset(x: 5.4, y: -0.3)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 5.9, height: 5.9)
                        .background(.gray)
                        .offset(x: 4.7, y: -7.0)
                    ZStack() {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 13.7, height: 10.7)
                            .offset(x: 0.0, y: 0.0)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 13.7, height: 10.7)
                            .background(.gray)
                            .offset(x: 0.0, y: 0.0)
                    }
                    .frame(width: 13.7, height: 10.7)
                    .offset(x: -3.8, y: 4.6)
                    Rectangle()
                        .foregroundColor(.clear)
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
    ContentView()
}
