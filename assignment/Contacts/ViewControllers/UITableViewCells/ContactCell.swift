//
//  ContactCell.swift
//  Contacts
//
//  Created by Ravindra Patidar on 13/09/19.
//  Copyright © 2019 GoJek. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet weak var contactPhotoView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactFavouriteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contactPhotoView.layer.cornerRadius = contactPhotoView.frame.size.height/2
        contactPhotoView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contactPhotoView.image = nil
        contactNameLabel.text = ""
        contactFavouriteImageView.image = nil
    }

}
