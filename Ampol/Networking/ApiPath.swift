//
//  ApiPath.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import Foundation

enum ApiPath {
    case getFuelTransactions
    case getChargingSessions
    case getDashboardDetails
}


extension ApiPath {
    private static let apiKey = "live_AMPOL_12345@"
    
    private var path: String {
        switch self {
        case .getFuelTransactions:
            return "/lastFuelTransactions"
        case .getChargingSessions:
            return "/lastChargingSessions"
        case .getDashboardDetails:
            return "/dashboardData"
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.ampol.com.au"
        components.path = ["/v1", self.path].joined()
        let queryAppId = URLQueryItem(name: "api_key", value: ApiPath.apiKey)
        let queryUserToken = URLQueryItem(name: "authentication", value: User.current.authToken)
        components.queryItems = [queryAppId, queryUserToken]
        return components.url
    }
}



