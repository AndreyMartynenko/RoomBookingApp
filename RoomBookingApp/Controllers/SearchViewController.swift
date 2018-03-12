//
//  SearchViewController.swift
//  RoomBookingApp
//
//  Created by Andrey on 3/11/18.
//

import UIKit
import Toast_Swift

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet fileprivate weak var dateButton: UIButton!
    @IBOutlet fileprivate weak var datePicker: UIDatePicker!
    @IBOutlet fileprivate weak var datePickerHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    fileprivate let datePickerHeight: CGFloat = 162.0
    fileprivate var viewModel: SearchViewModel!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Rooms"
        
        configureDatePicker()
        updateDate()
        
        viewModel = SearchViewModel(delegate: self)
        
        tableView.tableFooterView = UIView()
        datePickerHeightConstraint.constant = 0
        
        viewModel.start()
        viewModel.fetchRooms(date: datePicker.date)
    }
    
    deinit {
        viewModel.stop()
        viewModel = nil
    }
    
    // MARK: - Date
    
    fileprivate func updateDate() {
        dateButton.setTitle(Constants.dateFormatter.string(from: datePicker.date), for: .normal)
    }
    
    fileprivate func configureDatePicker() {
        datePicker.minimumDate = Date()
    }
    
    // MARK: - Actions
    
    @IBAction func dateButtonPressed(_ sender: UIButton) {
        if datePickerHeightConstraint.constant == datePickerHeight {
            view.layoutIfNeeded()
            UIView.animate(withDuration: 0.33, animations: {
                self.datePickerHeightConstraint.constant = 0
                self.view.layoutIfNeeded()
            })
            
            viewModel.fetchRooms(date: datePicker.date)
        } else {
            view.layoutIfNeeded()
            UIView.animate(withDuration: 0.33, animations: {
                self.datePickerHeightConstraint.constant = self.datePickerHeight
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDate()
    }
    
    @IBAction func roomAvailabilitySwitchValueChanged(_ sender: UISwitch) {
        viewModel.filter(availability: sender.isOn)
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.itemPressed(at: indexPath.row)
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RoomDetailsViewController") as? RoomDetailsViewController {
            viewController.room = viewModel.item(at: indexPath.row)
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as! RoomCell
        
        cell.configureCell(room: viewModel.item(at: indexPath.row))
        
        return cell
    }
    
}

extension SearchViewController: SearchViewModelDelegate {
    
    func onRoomsUpdated() {
        tableView.reloadData()
        
        DispatchQueue.main.async {
            self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.tableHeaderView?.frame.height ?? 0), animated: true)
        }
    }
    
    func onError(error: NetworkError) {
        navigationController?.view.makeToast(error.localizedDescription)
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text {
            viewModel.filter(name: text)
        }
        
        return true
    }
    
}
