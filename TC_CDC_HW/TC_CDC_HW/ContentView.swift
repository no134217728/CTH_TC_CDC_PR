//
//  ContentView.swift
//  TC_CDC_HW
//
//  Created by tpi on 2025/3/12.
//

import SwiftUI

struct ContentView: View {
    @State var isOnNotificationsView: Bool = false
    @State private var hasAppeared = false
    @State private var isShowAmount: Bool = false
    @State private var currentPage = 0
    
    @ObservedObject var viewModel = ContentViewModel()
    
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 0) {
                        HStack {
                            Spacer(minLength: 24)
                            Image("avatar").clipShape(.circle)
                            Spacer().frame(maxWidth: .infinity)
                            Button {
                                isOnNotificationsView = true
                            } label: {
                                if let messages = viewModel.notificationList?.messages, !messages.isEmpty {
                                    Image("iconBell02Active")
                                } else {
                                    Image("iconBell01Nomal")
                                }
                            }.navigationDestination(isPresented: $isOnNotificationsView, destination: {
                                NotificationsView(isOnNotificationsView: $isOnNotificationsView,
                                                  notificationList: viewModel.notificationList?.messages ?? [])
                            }).frame(width: 24, height: 24)
                            Spacer(minLength: 24)
                        }.frame(height: 48)
                        HStack {
                            Spacer(minLength: 24)
                            Text("My Account Balance")
                                .fontWeight(.heavy)
                                .font(.system(size: 18))
                                .foregroundStyle(cubeGray5)
                                .frame(height: 24.0)
                                .layoutPriority(1)
                            Button {
                                isShowAmount = !isShowAmount
                            } label: {
                                if isShowAmount {
                                    Image("iconEye01On")
                                } else {
                                    Image("iconEye02Off")
                                }
                            }.frame(width: 24, height: 24)
                            Spacer(minLength: 24).frame(maxWidth: .infinity)
                        }.frame(height: 48)
                        VStack(spacing: 0) {
                            HStack {
                                Spacer(minLength: 24)
                                Text("USD")
                                    .font(.system(size: 16))
                                    .foregroundStyle(cubeGray7)
                                    .frame(height: 24.0)
                                Spacer().frame(maxWidth: .infinity)
                            }
                            HStack {
                                Spacer(minLength: 24)
                                if viewModel.usdLoading {
                                    ProgressView().frame(height: 32.0)
                                } else {
                                    Text(isShowAmount ? viewModel.usdTotal : "********")
                                        .font(.system(size: 24))
                                        .foregroundStyle(cubeGray8)
                                        .frame(height: 32.0)
                                }
                                Spacer().frame(maxWidth: .infinity)
                            }
                        }.frame(height: 64)
                        VStack(spacing: 0) {
                            HStack {
                                Spacer(minLength: 24)
                                Text("KHR")
                                    .font(.system(size: 16))
                                    .foregroundStyle(cubeGray7)
                                    .frame(height: 24.0)
                                Spacer().frame(maxWidth: .infinity)
                            }
                            HStack {
                                Spacer(minLength: 24)
                                if viewModel.khrLodaing {
                                    ProgressView().frame(height: 32.0)
                                } else {
                                    Text(isShowAmount ? viewModel.khrTotal : "********")
                                        .font(.system(size: 24))
                                        .foregroundStyle(cubeGray8)
                                        .frame(height: 32.0)
                                }
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
                                .foregroundStyle(cubeGray5)
                                .frame(height: 24.0)
                            Spacer().frame(maxWidth: .infinity)
                            Text("More")
                                .font(.system(size: 16))
                                .foregroundStyle(cubeGray7)
                                .frame(height: 24.0)
                            Image("iconArrow01Next")
                            Spacer(minLength: 16)
                        }.frame(height: 48)
                        if viewModel.favoriteLoading {
                            ProgressView().frame(height: 88)
                        } else {
                            if let favors = viewModel.favoriteList?.favoriteList,
                               !favors.isEmpty {
                                VStack {
                                    Spacer(minLength: 4)
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 0) {
                                            Spacer(minLength: 24)
                                            LazyHStack(spacing: 0) {
                                                ForEach(favors.indices, id: \.self) { index in
                                                    let favor = favors[index]
                                                    FavoriteButton(iconType: favor.transType,
                                                                   title: favor.nickname)
                                                }
                                            }
                                        }
                                    }
                                    Spacer(minLength: 4)
                                }.frame(height: 88)
                            } else {
                                HStack(alignment: .top, spacing: 0) {
                                    Spacer(minLength: 24)
                                    VStack(spacing: 0) {
                                        Image("button00ElementScrollEmpty 1")
                                        Text("- - -")
                                            .foregroundStyle(cubeGray6)
                                            .font(.system(size: 12))
                                            .frame(height: 24)
                                    }.frame(width: 80, height: 80)
                                    Text("You can add a favorite through the transfer or payment function.")
                                        .font(.system(size: 14))
                                        .foregroundStyle(cubeGray6)
                                        .alignmentGuide(.top) { _ in
                                            -12
                                        }
                                    Spacer(minLength: 24)
                                }.frame(height: 88)
                            }
                        }
                        if let bannerList = viewModel.bannerList?.bannerList {
                            Spacer(minLength: 16)
                            VStack {
                                Spacer(minLength: 4)
                                TabView(selection: $currentPage) {
                                    ForEach(bannerList.indices, id: \.self) { index in
                                        let banner = bannerList[index]
                                        BannerView(imageUrl: banner.linkUrl)
                                    }
                                }
                                .tabViewStyle(.page(indexDisplayMode: .never))
                                .onReceive(timer) { _ in
                                    withAnimation {
                                        currentPage = (currentPage + 1) % bannerList.count
                                    }
                                }
                                Spacer(minLength: 4)
                            }
                            .frame(height: 96)
                            PageControl(currentPage: $currentPage, totalPages: viewModel.bannerList?.bannerList.count ?? 0)
                                .frame(height: 20)
                        }
                        Spacer(minLength: 72)
                    }.frame(maxWidth: .infinity)
                }.task {
                    if !hasAppeared {
                        viewModel.fetchEmptyNotificationList()
                        viewModel.fetchEmptyFavorite()
                        async let _ = viewModel.fetch1stAllData()
                        async let _ = viewModel.fetchBanners()
                        hasAppeared = true
                    }
                }.refreshable(action: {
                    viewModel.fetchNotifications()
                    async let _ = viewModel.fetchFavoriteList()
                    async let _ = viewModel.fetchPRAllData()
                })
                .alert("Error", isPresented: Binding(get: {
                    viewModel.error != nil
                }, set: { _ in
                    viewModel.error = nil
                }), actions: {
                    Button("OK", role: .cancel) {}
                }, message: {
                    Text(viewModel.error?.message ?? "")
                })
                .navigationBarHidden(true)
                .background(mainBackground)
                VStack {
                    Spacer()
                    HStack {
                        Spacer(minLength: 24)
                        ZStack {
                            Rectangle()
                                .foregroundStyle(.clear)
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
                    Spacer().frame(height: 22)
                }
            }
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

struct BannerView: View {
    let imageUrl: String
    
    var body: some View {
        HStack {
            Spacer(minLength: 24)
            AsyncImage(url: URL(string: imageUrl)) { phase in
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
                    .foregroundStyle(currentPage == index ? .black : grayDot)
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
    ContentView()
}
