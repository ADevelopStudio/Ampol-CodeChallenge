//
//  CarouselView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import SwiftUI
struct FuelCarouselView: View {
    private let cardSize = CGSize(width: Utilites.screenWidth/1.5, height:  Utilites.screenWidth/2)
    var transactions: [FuelTransaction]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 35) {
                ForEach(transactions.prefix(2)) { transaction in
                    GeometryReader { proxy in
                        let scale = self.getScale(proxy: proxy)
                        NavigationLink {
                            FuelSingleTransactionView(transaction: transaction)
                        } label: {
                            FuelCardView(transaction: transaction)
                                .asCarouselCard(cardSize: cardSize, scale: scale)
                                .tint(.primary)
                        }
                    }
                    .frame(width: cardSize.width, height: cardSize.height)
                }
                
                GeometryReader { proxy in
                    let scale = self.getScale(proxy: proxy)
                    NavigationLink {
                        FuelAllTransactionsView(transactions: transactions)
                    } label: {
                        VStack(spacing: 20) {
                            Image(systemName: "chevron.right.circle.fill")
                                .imageScale(.large)
                                .font(.largeTitle)
                                .foregroundColor(.accentColor)
                            Text(FuelCarouselViewStrings.seeAll.localised)
                                .font(.headline)
                                .foregroundColor(.accentColor)
                        }
                        .asCarouselCard(cardSize: cardSize, scale: scale)
                        .tint(.primary)
                    }
                }
                .frame(width: cardSize.width, height: cardSize.height)
            }
            .padding(35)
        }
    }
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        let diff = abs(proxy.frame(in: .global).minX)
        if diff > 100 {
            scale = 1 - (diff - 100) / 1000
        }
        return scale
    }
}


enum FuelCarouselViewStrings: String, CaseIterable {
    case seeAll = "FuelCarouselView_See_all" //"See all";
}
