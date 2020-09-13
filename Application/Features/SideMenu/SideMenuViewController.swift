//
//  SideMenuViewController.swift
//  Src
//
//  Created by BobaHasseb on 8/14/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    var menuOptions = ["عن التطبيق", "الشروط والسياسات", "الفعاليات", "البطولات"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
}
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MenueCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenueCell else {
            return  UITableViewCell()
        }
        cell.optionName.text = menuOptions[indexPath.row]
        cell.optionImage.image = UIImage(named: menuOptions[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let destinationVC =
                AboutApplicationViewController.instantiateFromNib() {
                self.navigationController?.pushViewController(destinationVC,
                                                              animated: true)
            }
        } else if indexPath.row == 1 {
            if let destinationVC =
                TermsAndpolicesViewController.instantiateFromNib() {
                self.navigationController?.pushViewController(destinationVC,
                                                              animated: true)
            }
        } else if indexPath.row == 2 {
            if let destinationVC =
                EventsViewController.instantiateFromNib() {
                self.navigationController?.pushViewController(destinationVC,
                                                              animated: true)
            }
         } else if indexPath.row == 3 {
                   if let destinationVC =
                       ChampionsViewController.instantiateFromNib() {
                       self.navigationController?.pushViewController(destinationVC,
                                                                     animated: true)
                   }
               }
    }
}
