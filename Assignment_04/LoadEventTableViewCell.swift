//
//  LoadEventTableViewCell.swift
//  Assignment_04
//
//  Created by Ravi Rachamalla on 2020-11-24.
//

import UIKit

class LoadEventTableViewCell: UITableViewCell {

    @IBOutlet weak var cellEventTitle: UILabel!
    @IBOutlet weak var cellEventTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
