//
//  Requests.swift
//  TC_CDC_HW
//
//  Created by tpi on 2025/3/14.
//

import Foundation

struct RequestEmptyNotificationList: Request {
    typealias Response = NotificationList
    
    let path: Endpoint = .emptyNotificationList
}

struct RequestNotificationList: Request {
    typealias Response = NotificationList
    
    let path: Endpoint = .notificationList
}

struct RequestUsdSavings1: Request {
    typealias Response = SavingList
    
    let path: Endpoint = .usdSavings1
}

struct RequestUsdFixed1: Request {
    typealias Response = FixedList
    
    let path: Endpoint = .usdFixed1
}

struct RequestUsdDigital1: Request {
    typealias Response = DigitalList
    
    let path: Endpoint = .usdDigital1
}

struct RequestUsdSavings2: Request {
    typealias Response = SavingList
    
    let path: Endpoint = .usdSavings2
}

struct RequestUsdFixed2: Request {
    typealias Response = FixedList
    
    let path: Endpoint = .usdFixed2
}

struct RequestUsdDigital2: Request {
    typealias Response = DigitalList
    
    let path: Endpoint = .usdDigital2
}

struct RequestKhrSavings1: Request {
    typealias Response = SavingList
    
    let path: Endpoint = .khrSavings1
}

struct RequestKhrFixed1: Request {
    typealias Response = FixedList
    
    let path: Endpoint = .khrFixed1
}

struct RequestKhrDigital1: Request {
    typealias Response = DigitalList
    
    let path: Endpoint = .khrDigital1
}

struct RequestKhrSavings2: Request {
    typealias Response = SavingList
    
    let path: Endpoint = .khrSavings2
}

struct RequestKhrFixed2: Request {
    typealias Response = FixedList
    
    let path: Endpoint = .khrFixed2
}

struct RequestKhrDigital2: Request {
    typealias Response = DigitalList
    
    let path: Endpoint = .khrDigital2
}

struct RequestEmptyFavoriteList: Request {
    typealias Response = FavoriteList
    
    let path: Endpoint = .emptyFavoriteList
}

struct RequestFavoriteList: Request {
    typealias Response = FavoriteList
    
    let path: Endpoint = .favoriteList
}

struct RequestBanner: Request {
    typealias Response = BannerList
    
    let path: Endpoint = .banner
}
