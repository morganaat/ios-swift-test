//
//  ListTableViewCell.swift
//  TestApp
//
//  Created by Morgana Timbo on 2019-11-19.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func format(_ note: Note) {
        self.timestampLabel.text = note.date
        self.bodyLabel.text = note.noteText
    }

}
