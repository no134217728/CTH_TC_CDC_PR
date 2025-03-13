//
//  Models.swift
//  TC_CDC_HW
//
//  Created by tpi on 2025/3/13.
//

import Foundation

struct Response<T: Codable>: Codable {
    let msgCode: String
    let msgContent: String
    let result: T
}

struct NotificationList: Codable {
    let messages: [Message]?
    
    struct Message: Codable {
        let status: Bool
        let updateDateTime: String
        let title: String
        let message: String
    }
}

struct SavingList: Codable {
    let savingsList: [Balance]
}

struct FixedList: Codable {
    let fixedDepositList: [Balance]
}

struct DigitalList: Codable {
    let digitalList: [Balance]
}

struct Balance: Codable {
    let account: String
    let curr: Currency
    let balance: Double
}

struct FavoriteList: Codable {
    let favoriteList: [Favorite]?
    
    struct Favorite: Codable {
        let nickname: String
        let transType: FavoriteType
    }
}

struct BannerList: Codable {
    let bannerList: [Banner]
    
    struct Banner: Codable {
        let adSeqNo: Int
        let linkUrl: String
    }
}
