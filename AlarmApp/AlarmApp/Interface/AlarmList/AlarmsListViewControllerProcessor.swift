//
//  AlarmsListViewControllerProcessor.swift
//  AlarmApp
//
//  Created by Brice Pollock on 2/20/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

struct AlarmsListViewControllerProcessor {
    let emptyVotesString = "0 votes"
    func createViewData(for alarms: [HandshakeAlarm], actionDelegate: AlarmTableViewCellDelegate) -> [AlarmTableViewCellData] {
        // TODO: test the sorting and elimination of empty strings
        let sortedAlarms = alarms.sorted { (left, right) -> Bool in
            return left.updatedAt > right.updatedAt
        }
        return sortedAlarms.flatMap { (alarm) in
            // there are a lot of empty body alarms that make a poor experience.
            // So we are going to eliminate them here
            guard let body = alarm.body else { return nil}
            return AlarmTableViewCellData(
                body: bodyString(from: body),
                voteString: voteString(from: alarm.votes),
                alarm: alarm,
                delegate: actionDelegate
            )
        }
    }
    
    func bodyString(from body: String) -> String {
        return body.uppercased()
    }
    
    func voteString(from votes: Int?) -> String {
        guard let votes = votes else { return emptyVotesString }
        if votes < 0 { return emptyVotesString }
        return "\(votes) votes"
    }
}
