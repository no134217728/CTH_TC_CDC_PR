//
//  ContentViewModel.swift
//  TC_CDC_HW
//
//  Created by tpi on 2025/3/13.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    private let network = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter
    }()
    
    @Published var error: NetworkError?
    @Published var notificationList: NotificationList?
    @Published var usdTotal: String = ""
    @Published var khrTotal: String = ""
    @Published var favoriteList: FavoriteList?
    @Published var bannerList: BannerList?
    
    @Published var usdLoading: Bool = false
    @Published var khrLodaing: Bool = false
    @Published var favoriteLoading: Bool = false
    
    func fetchEmptyNotificationList() {
        do {
            try network.requestData(request: RequestEmptyNotificationList())
                .receive(on: RunLoop.main)
                .sink { data in
                    switch data {
                    case .failure(let error):
                        Task { await self.handleError(error: error) }
                    case .finished:
                        break
                    }
                } receiveValue: { data in
                    self.notificationList = data
                }.store(in: &cancellables)
        } catch {
            Task { await handleError(error: error) }
        }
    }
    
    func fetch1stAllData() async {
        do {
            await MainActor.run {
                usdLoading = true
                khrLodaing = true
            }
            
            let usdSaving = try network.requestData(request: RequestUsdSavings1())
            let usdFixed = try network.requestData(request: RequestUsdFixed1())
            let usdDigital = try network.requestData(request: RequestUsdDigital1())
            Publishers.Zip3(usdSaving, usdFixed, usdDigital)
                .receive(on: RunLoop.main)
                .sink { data in
                    self.usdLoading = false
                    
                    switch data {
                    case .failure(let error):
                        Task { await self.handleError(error: error) }
                    case .finished:
                        break
                    }
                } receiveValue: { (saving, fixed, digital) in
                    let usdSaving = saving.savingsList.reduce(0.0) { $0 + $1.balance }
                    let usdFixed = fixed.fixedDepositList.reduce(0.0) { $0 + $1.balance }
                    let usdDigital = digital.digitalList.reduce(0.0) { $0 + $1.balance }

                    if let formattedString = self.formatter.string(from: NSNumber(value: usdSaving + usdFixed + usdDigital)) {
                        self.usdTotal = formattedString
                    }
                }.store(in: &cancellables)
            
            let khrSaving = try network.requestData(request: RequestKhrSavings1())
            let khrFixed = try network.requestData(request: RequestKhrFixed1())
            let khrDigital = try network.requestData(request: RequestKhrDigital1())
            Publishers.Zip3(khrSaving, khrFixed, khrDigital)
                .receive(on: RunLoop.main)
                .sink { data in
                    self.khrLodaing = false
                    
                    switch data {
                    case .failure(let error):
                        Task { await self.handleError(error: error) }
                    case .finished:
                        break
                    }
                } receiveValue: { (saving, fixed, digital) in
                    let khrSaving = saving.savingsList.reduce(0.0) { $0 + $1.balance }
                    let khrFixed = fixed.fixedDepositList.reduce(0.0) { $0 + $1.balance }
                    let khrDigital = digital.digitalList.reduce(0.0) { $0 + $1.balance }
                    
                    if let formattedString = self.formatter.string(from: NSNumber(value: khrSaving + khrFixed + khrDigital)) {
                        self.khrTotal = formattedString
                    }
                }.store(in: &cancellables)
        } catch {
            await MainActor.run {
                usdLoading = false
                khrLodaing = false
                handleError(error: error)
            }            
        }
    }
    
    func fetchEmptyFavorite() {
        do {
            try network.requestData(request: RequestEmptyFavoriteList())
                .receive(on: RunLoop.main)
                .sink { data in
                    switch data {
                    case .failure(let error):
                        Task { await self.handleError(error: error) }
                    case .finished:
                        break
                    }
                } receiveValue: { data in
                    self.favoriteList = data
                }.store(in: &cancellables)
        } catch {
            Task { await handleError(error: error) }
        }
    }
    
    func fetchNotifications() {
        do {
            try network.requestData(request: RequestNotificationList())
                .receive(on: RunLoop.main)
                .sink { data in
                    switch data {
                    case .failure(let error):
                        Task { await self.handleError(error: error) }
                    case .finished:
                        break
                    }
                } receiveValue: { data in
                    self.notificationList = data
                }.store(in: &cancellables)
        } catch {
            Task { await handleError(error: error) }
        }
    }
    
    func fetchPRAllData() async {
        do {
            await MainActor.run {
                usdLoading = true
                khrLodaing = true
            }
            
            let usdSaving = try network.requestData(request: RequestUsdSavings2())
            let usdFixed = try network.requestData(request: RequestUsdFixed2())
            let usdDigital = try network.requestData(request: RequestUsdDigital2())
            Publishers.Zip3(usdSaving, usdFixed, usdDigital)
                .receive(on: RunLoop.main)
                .sink { data in
                    self.usdLoading = false
                    
                    switch data {
                    case .failure(let error):
                        Task { await self.handleError(error: error) }
                    case .finished:
                        break
                    }
                } receiveValue: { (saving, fixed, digital) in
                    let usdSaving = saving.savingsList.reduce(0.0) { $0 + $1.balance }
                    let usdFixed = fixed.fixedDepositList.reduce(0.0) { $0 + $1.balance }
                    let usdDigital = digital.digitalList.reduce(0.0) { $0 + $1.balance }
                    
                    if let formattedString = self.formatter.string(from: NSNumber(value: usdSaving + usdFixed + usdDigital)) {
                        self.usdTotal = formattedString
                    }
                }.store(in: &cancellables)
            
            let khrSaving = try network.requestData(request: RequestKhrSavings2())
            let khrFixed = try network.requestData(request: RequestKhrFixed2())
            let khrDigital = try network.requestData(request: RequestKhrDigital2())
            Publishers.Zip3(khrSaving, khrFixed, khrDigital)
                .receive(on: RunLoop.main)
                .sink { data in
                    self.khrLodaing = false
                    
                    switch data {
                    case .failure(let error):
                        Task { await self.handleError(error: error) }
                    case .finished:
                        break
                    }
                } receiveValue: { (saving, fixed, digital) in
                    let khrSaving = saving.savingsList.reduce(0.0) { $0 + $1.balance }
                    let khrFixed = fixed.fixedDepositList.reduce(0.0) { $0 + $1.balance }
                    let khrDigital = digital.digitalList.reduce(0.0) { $0 + $1.balance }
                    
                    if let formattedString = self.formatter.string(from: NSNumber(value: khrSaving + khrFixed + khrDigital)) {
                        self.khrTotal = formattedString
                    }
                }.store(in: &cancellables)
        } catch {
            await MainActor.run {
                usdLoading = false
                khrLodaing = false
                handleError(error: error)
            }
        }
    }
    
    func fetchFavoriteList() async {
        do {
            await MainActor.run {
                favoriteLoading = true
            }
            
            try network.requestData(request: RequestFavoriteList())
                .receive(on: RunLoop.main)
                .sink { data in
                    self.favoriteLoading = false
                    
                    switch data {
                    case .failure(let error):
                        Task { await self.handleError(error: error) }
                    case .finished:
                        break
                    }
                } receiveValue: { data in
                    self.favoriteList = data
                }.store(in: &cancellables)
        } catch {
            await MainActor.run {
                favoriteLoading = false
                handleError(error: error)
            }
        }
    }
    
    func fetchBanners() async {
        do {
            try network.requestData(request: RequestBanner())
                .receive(on: RunLoop.main)
                .sink { data in
                    switch data {
                    case .failure(let error):
                        Task { await self.handleError(error: error) }
                    case .finished:
                        break
                    }
                } receiveValue: { data in
                    self.bannerList = data
                }.store(in: &cancellables)
        } catch {
            await handleError(error: error)
        }
    }
    
    @MainActor
    private func handleError(error: Error) {
        guard let err = error as? NetworkError else {
            self.error = NetworkError(code: .ErrorMessage,
                                      message: error.localizedDescription)
            return
        }
        
        self.error = err
    }
}
