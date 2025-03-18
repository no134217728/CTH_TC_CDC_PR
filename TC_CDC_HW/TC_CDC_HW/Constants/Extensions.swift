//
//  Extensions.swift
//  TC_CDC_HW
//
//  Created by tpi on 2025/3/14.
//

import Foundation

extension Data {
    @discardableResult
    func prettyPrint(title: String) -> String {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyString = String(data: data, encoding: .utf8) else {
            print("PrettyPrint Original \(title): \(String(describing: String(data: self, encoding: .utf8)))")
            return ""
        }
        
        print("\(title): " + prettyString)
        return prettyString
    }
}
