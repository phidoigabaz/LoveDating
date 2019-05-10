//
//  MenuViewController.swift
//  NavigationApp
//
//  Created by GEM on 4/18/19.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dismissButton: UIButton!
    let baseDataModel = BaseDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: METHODS
    override func setupView() {
        dismissButton.setRadiusButton(dismissButton.frame.height/2)
        baseDataModel.parseMenuData()
    }
    
    //MARK: ACTIONS
    @IBAction func onDismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension MenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return baseDataModel.sectionModel.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baseDataModel.sectionModel[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowModel = baseDataModel.sectionModel[indexPath.section].rows[indexPath.row]
        let cell = MenuItemTableViewCell.dequeueReuseCellWithNib(in: tableView, reuseIdentifier: MenuItemTableViewCell.nibName())
        cell.titleLabel.text = rowModel.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard baseDataModel.sectionModel.count > section else {
            return nil
        }
        let view = BaseHeaderTableView.dequeueReuseHeaderWithNib(in: tableView, reuseIdentifier: BaseHeaderTableView.nibName())
        view.titleLabel.text = baseDataModel.sectionModel[section].header.title
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension MenuViewController: UITableViewDelegate {
   
}
