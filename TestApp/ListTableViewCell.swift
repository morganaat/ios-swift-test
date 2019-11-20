//
//  ListTableViewCell.swift
//  TestApp
//
//  Created by Morgana Timbo on 2019-11-19.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func format(_ note: Note) {
        self.titleLabel.text = note.title
        self.timestampLabel.text = "\(note.timeStamp)"
        self.bodyLabel.text = note.body
    }

}
