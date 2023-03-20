//
//  Enums.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import Foundation

enum LoadingState: Equatable {
    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        rhs.equal == lhs.equal
    }
    
    case idle
    case loading
    case failed(Error)
    
    private var equal: String {
        switch self {
        case .idle:
            return "idle"
        case .loading:
            return "loading"
        case .failed(let error):
            return error.localizedDescription
        }
    }
}

