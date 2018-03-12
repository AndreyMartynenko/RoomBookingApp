//
//  RoomDetailsViewController.swift
//  RoomBookingApp
//
//  Created by Andrey on 3/11/18.
//

import Foundation
import UIKit

class RoomDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var room: Room!
    
    @IBOutlet weak var availabilityView: TimeBar!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var equipmentLabel: UILabel!
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var firstImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdImageViewWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Configuration
    
    func configureView() {
        title = room.name
        availabilityView.configure(with: room.avail)
        locationLabel.text = room.location
        sizeLabel.text = room.size
        if let capacity = room.capacity {
            capacityLabel.text = String(describing: capacity)
        }
        configureEquipment()
        configureImages()
    }
    
    func configureEquipment() {
        if let roomEquipment = room.equipment {
            var equipment = ""
            for item in roomEquipment {
                equipment.append(item)
                equipment.append(", ")
            }
            equipmentLabel.text = String(equipment.dropLast(2))
        }
    }
    
    func configureImages() {
        if let images = room.images {
            var imageViews: [UIImageView] = [firstImageView, secondImageView, thirdImageView]
            for (index, image) in images.enumerated() {
                imageViews[index].imageFromUrl(urlString: image)
                
                if imageViews[index].image == nil {
                    imageViews[index].image = UIImage(named: "ic_no_image")
                }
            }
            
            var imageViewConstraints: [NSLayoutConstraint] = [firstImageViewWidthConstraint, secondImageViewWidthConstraint, thirdImageViewWidthConstraint]
            for _ in 0..<(imageViews.count - images.count) {
                if let constraint = imageViewConstraints.last {
                    constraint.constant = 0
                    imageViewConstraints.removeLast()
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func bookButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
}
