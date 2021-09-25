//
//  ImageTblCell.swift
//  Smoothie
//
//  Created by Ajay Yadav on 25/09/21.
//

import UIKit

class ImageTblCell: UITableViewCell {

    @IBOutlet weak var vwContentCell: UIView!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var imgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        vwContentCell.layer.cornerRadius = 5.0
        vwContentCell.layer.shadowRadius = 5.0
        vwContentCell.layer.shadowOpacity = 0.9
        vwContentCell.layer.shadowOffset = CGSize(width: 0, height: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
