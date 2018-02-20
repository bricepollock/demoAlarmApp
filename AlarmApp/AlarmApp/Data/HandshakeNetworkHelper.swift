//
//  HandshakeService.swift
//  AlarmApp
//
//  Created by Brice Pollock on 2/20/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

enum HandshakeRoute {
    case alarms
    case updateAlarm(Int)
    
    var rawValue: String {
        switch self {
        case .alarms: return "alarms.json"
        case .updateAlarm(let remoteId): return "alarms/\(remoteId).json"
        }
    }
}

struct HandshakeNetworkHelper {
    private let scheme = "https"
    private let host = "bellbird.joinhandshake-internal.com"
    
    func createURL(for route: HandshakeRoute, with queries: [URLQueryItem]? = nil)  -> URL? {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "/\(route.rawValue)"
        urlComponents.queryItems = queries
        return urlComponents.url
    }
}
