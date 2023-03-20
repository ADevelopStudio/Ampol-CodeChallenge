//
//  Modifiers.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import SwiftUI

private struct CarouselCardView: ViewModifier {
    var cardSize: CGSize
    var scale: CGFloat
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.accentColor, lineWidth: 1)
                .shadow(radius: 6)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(uiColor: .quaternarySystemFill).opacity(0.6))
                        .shadow(color: Color.secondary.opacity(0.5), radius: 5, x: 3, y: 2)
                )
            content
                .frame(width: cardSize.width, height: cardSize.height)
                .padding()
                .cornerRadius(10)
                .clipped()
            
        }
        .frame(width: cardSize.width, height: cardSize.height)
        .scaleEffect(CGSize(width: scale, height: scale))
    }
}

private struct CardView: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.accentColor, lineWidth: 1)
                .shadow(radius: 6)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(uiColor: .quaternarySystemFill).opacity(0.6))
                        .shadow(color: Color.secondary.opacity(0.5), radius: 5, x: 3, y: 2)
                )
            content
                .padding()
                .cornerRadius(10)
                .clipped()
            
        }
    }
}


extension View {
    func asCarouselCard(cardSize: CGSize, scale: CGFloat) -> some View {
        modifier(CarouselCardView(cardSize: cardSize, scale: scale))
    }
    
    func asCard() -> some View {
        modifier(CardView())
    }
}
