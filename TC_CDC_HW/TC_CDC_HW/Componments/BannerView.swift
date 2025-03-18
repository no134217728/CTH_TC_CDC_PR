//
//  BannerView.swift
//  TC_CDC_HW
//
//  Created by tpi on 2025/3/18.
//

import SwiftUI

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

#Preview {
    BannerView(imageUrl: "https://willywu0201.github.io/data/banner1.jpg")
}
