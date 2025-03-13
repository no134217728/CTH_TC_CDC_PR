//
//  Network.swift
//  TC_CDC_HW
//
//  Created by tpi on 2025/3/13.
//

import Foundation
import Combine

enum Endpoint: String {
    case emptyNotificationList
    case notificationList
    case usdSavings1
    case usdFixed1
    case usdDigital1
    case usdSavings2
    case usdFixed2
    case usdDigital2
    case khrSavings1
    case khrFixed1
    case khrDigital1
    case khrSavings2
    case khrFixed2
    case khrDigital2
    case emptyFavoriteList
    case favoriteList
    case banner
}

enum NetworkErrorType: Error {
    case TaskError
    case NoHTTPResponse
    case DecodeError
    case Redirecting
    case BadRequest
    case ServerError
    case DataMissing
    case ErrorMessage
    case UnexpectedError
}

protocol Request {
    associatedtype Response: Codable
    
    var path: Endpoint { get }
}

struct NetworkError: Error {
    let code: NetworkErrorType
    let message: String
}

struct ErrorMessage: Decodable {
    let errorMessage: String
    let status: String
}

class NetworkManager: NSObject {
    lazy var session: URLSession = {
        URLSession(configuration: .default)
    }()
    
    func requestData<R: Request>(request: R) throws -> AnyPublisher<R.Response, Error> {
        let urlStr = "https://willywu0201.github.io/data/\(request.path.rawValue).json"
        
        guard let url = URL(string: urlStr) else {
            throw NetworkError(code: .DataMissing, message: "Invalid URL string.")
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.timeoutInterval = 5
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError(code: .NoHTTPResponse, message: "API request: \(request.url?.absoluteString ?? "") no response")
                }
                
                let statusCode = httpResponse.statusCode
                switch statusCode {
                case 200..<300:
                    data.prettyPrint(title: "Response Data")
                    return data
                default:
                    throw self.handleError(statusCode: statusCode, errResData: data)
                }
            }.decode(type: Response<R.Response>.self, decoder: JSONDecoder())
            .tryCompactMap({ response in
                if response.msgCode == "0000" {
                    return response.result
                } else {
                    throw NetworkError(code: .ErrorMessage, message: "\(response.msgCode) \(response.msgContent)")
                }
            })
            .eraseToAnyPublisher()
    }
    
    private func handleError(statusCode: Int, errResData: Data) -> NetworkError {
        var errorType: NetworkErrorType = .UnexpectedError
        switch statusCode {
        case 300..<400: errorType = .Redirecting
        case 400..<500: errorType = .BadRequest
        case 500..<600: errorType = .ServerError
        default: errorType = .UnexpectedError
        }
        
        if let errRes = try? JSONDecoder().decode(ErrorMessage.self, from: errResData) {
            return NetworkError(code: errorType, message: "\(statusCode) \(errRes.errorMessage)")
        } else {
            return NetworkError(code: errorType, message: "\(statusCode)")
        }
    }
}
