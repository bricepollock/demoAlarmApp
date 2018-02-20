//
//  AlarmTableViewCell.swift
//  AlarmApp
//
//  Created by Brice Pollock on 2/20/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit

protocol AlarmTableViewCellDelegate: class {
    func didPressUpvote(_ didUpvote: Bool, for alarm: HandshakeAlarm)
}

struct AlarmTableViewCellData {
    let body: String
    let voteString: String
    let alarm: HandshakeAlarm
    weak var delegate: AlarmTableViewCellDelegate?
}

class AlarmTableViewCell: UITableViewCell {
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var upvoteButton: UIButton!
    
    var data: AlarmTableViewCellData?
    
    // place these here for future localization
    let upvoteString = "Upvote"
    let downvoteString = "Downvote"
    
    static let name = String(describing: AlarmTableViewCell.self)
    static func register(in tableView: UITableView) {
        let nib = UINib(nibName: name, bundle: Bundle(for: self))
        tableView.register(nib, forCellReuseIdentifier: name)
    }
    
    func configure(with data: AlarmTableViewCellData) {
        self.data = data
        bodyLabel.text = data.body
        bodyLabel.font = UIFont.boldSystemFont(ofSize: 18)
        votesLabel.text = data.voteString
        upvoteButton.setTitle(upvoteString, for: .normal)
        upvoteButton.setTitle(downvoteString, for: .selected)
    }
    
    @IBAction func didPressUpvote(_ sender: Any) {
        guard let data = data else {
            logDebug("No data for pressed cell")
            return
        }
        data.delegate?.didPressUpvote(upvoteButton.isSelected, for: data.alarm)
        upvoteButton.isSelected = !upvoteButton.isSelected
    }
}
