//
//  ChangeLanguageViewController.swift
//  Src
//
//  Created by BobaHasseb on 9/11/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import UIKit

class ChangeLanguageViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var arabicButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = true
        self.arabicButton.isHidden = false
        self.arabicButton.isSelected = true
     }
    // MARK: - Arabic Button Action
    @IBAction func arabicButtonTapped(_ sender: Any) {
        self.arabicButton.isHidden = false
        self.englishButton.isHidden = true
        self.arabicButton.isSelected = true
        self.englishButton.isSelected = false
    }
    // MARK: - English Button Action
    @IBAction func englishButtonTapped(_ sender: Any) {
        self.englishButton.isHidden = false
        self.arabicButton.isHidden = true
        self.arabicButton.isSelected = false
        self.englishButton.isSelected = true
    }
    // MARK: - Accept Button Action
    @IBAction func acceptButtonTapped(_ sender: Any) {
        if arabicButton.isSelected {
            if LocalizationManager.shared.getLanguage() == .english {
                LocalizationManager.shared.setLanguage(language: .arabic)
            }
        } else if englishButton.isSelected {
            if LocalizationManager.shared.getLanguage() == .arabic {
                LocalizationManager.shared.setLanguage(language: .english)
            }
        }
    }
    // MARK: - Set refuse Button Action
    @IBAction func refuseButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
