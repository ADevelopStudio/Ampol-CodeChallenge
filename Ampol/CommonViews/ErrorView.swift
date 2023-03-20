//
//  ErrorView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import SwiftUI

struct ErrorView: View {
    var errorMessage: String

    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    init(error: Error) {
        self.errorMessage = error.localizedDescription
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "xmark.icloud")
                .imageScale(.large)
                .font(.largeTitle)
                .foregroundColor(.red)
            Text(errorMessage)
                .font(.title2)
                .foregroundColor(.red)
        }
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: ServiceError.generalFailure)
            .preferredColorScheme(.dark)
    }
}
