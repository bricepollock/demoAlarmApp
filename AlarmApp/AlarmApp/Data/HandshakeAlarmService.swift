//
//  HandshakeAlarmService.swift
//  AlarmApp
//
//  Created by Brice Pollock on 2/20/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation


struct HandshakeAlarmService {
    let network = NetworkManager()
    let handshakeHelper = HandshakeNetworkHelper()
    let encoder = JSONEncoder()
    
    func getAlarms(completion: @escaping ([HandshakeAlarm]?) -> Void) {
        guard let url = handshakeHelper.createURL(for: .alarms) else {
            completion(nil)
            logDebug("Unable to create URL to get alarms")
            return
        }
        network.makeURLRequest(for: url, with: completion)
    }
    
    func upvote(alarm remoteId: Int, votes: Int, completion: @escaping ((Bool?) -> Void)) {
        guard let url = handshakeHelper.createURL(for: .updateAlarm(remoteId)) else {
            completion(nil)
            logDebug("Unable to create URL to get alarms")
            return
        }
        
        let body = LocalHandshakeAlarmBody(alarm: LocalHandshakeAlarm(body: nil, votes: String(votes)))
        guard let encodedBody = try? encoder.encode(body) else {
            logDebug("Unable to encode upvote body")
            completion(nil)
            return
        }
        network.makeURLRequest(using: .put, for: url, containing: encodedBody, with: completion)
    }
    
    func createAlarm(text: String, completion: @escaping ((Bool?) -> Void)) {
        guard let url = handshakeHelper.createURL(for: .alarms) else {
            completion(nil)
            logDebug("Unable to create URL to get alarms")
            return
        }
        
        let body = LocalHandshakeAlarmBody(alarm: LocalHandshakeAlarm(body: text, votes: "0"))
        guard let encodedBody = try? encoder.encode(body) else {
            logDebug("Unable to encode create object body)")
            completion(nil)
            return
        }
        network.makeURLRequest(using: .put, for: url, containing: encodedBody, with: completion)
    }
}
