//
//  HandshakeAlarmStructs.swift
//  AlarmApp
//
//  Created by Brice Pollock on 2/20/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

typealias HandshakeAlarmResponse = [HandshakeAlarm]
struct HandshakeAlarm: Codable {
    let remoteId: Int
    let body: String?
    let votes: Int?
    let createdAt: String
    let updatedAt: String
    enum CodingKeys: String, CodingKey {
        case remoteId = "id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case body, votes
    }
}

struct LocalHandshakeAlarmBody: Codable {
    let alarm: LocalHandshakeAlarm
}

struct LocalHandshakeAlarm: Codable {
    let body: String?
    let votes: String
}
