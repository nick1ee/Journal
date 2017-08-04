//
//  JournalViewController.swift
//  Journal
//
//  Created by Nick Lee on 2017/8/4.
//  Copyright © 2017年 nicklee. All rights reserved.
//

import UIKit

class JournalViewController: UIViewController {

    let imagePicker = UIImagePickerController()

    var isImageLoaded: Bool = false

    var receivedJournal: Journal?

    @IBOutlet weak var uploadImageView: UIImageView!

    @IBOutlet weak var imageTapView: UIView!

    @IBOutlet weak var imagePlaceholder: UIButton!

    @IBOutlet weak var remindLabel: UILabel!

    @IBOutlet weak var inputTitle: UITextField!

    @IBOutlet weak var inputContent: UITextView!

    @IBOutlet weak var outletBtnSave: UIButton!

    @IBOutlet weak var outletBtnCancel: UIButton!

    @IBAction func bntCancel(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)

    }

    @IBAction func btnSave(_ sender: UIButton) {

        if receivedJournal == nil {

            saveToCoreData()

        } else {

            // MARK: Update journal.

            CoreDataProvider().deleteJournal(withJournal: receivedJournal!)

            saveToCoreData()

        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        inputContent.delegate = self

        imagePlaceholder.isEnabled = false

        imagePicker.delegate = self

        UIApplication.shared.statusBarStyle = .lightContent

        addTapForImagePicker()

        addImageSpotlight()

        if self.receivedJournal != nil {

            guard let data = receivedJournal?.imageData as? Data else { return }

            uploadImageView.image = UIImage(data: data)

            inputTitle.text = receivedJournal?.title

            inputContent.text = receivedJournal?.content

            imagePlaceholder.isHidden = true

            remindLabel.isHidden = true

            isImageLoaded = true

            outletBtnSave.setTitle("Update", for: .normal)

        }

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.receivedJournal = nil

    }

}
