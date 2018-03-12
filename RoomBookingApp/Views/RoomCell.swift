//
//  RoomCell.swift
//  RoomBookingApp
//
//  Created by Andrey on 3/11/18.
//

import UIKit

class RoomCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var availabilityView: TimeBar!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        availabilityView.clear()
    }
    
    func configureCell(room: Room) {
        nameLabel.text = room.name
        locationLabel.text = room.location
        availabilityView.configure(with: room.avail)
    }
    
}
