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

//    @IBOutlet weak var defaultImageView: UIImageView!

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

            CoreDataProvider().deleteJournal(withJournal: receivedJournal!)

            saveToCoreData()

        }

    }

    func saveToCoreData() {

        if isImageLoaded == true,
            inputTitle.text != "",
            inputContent.text != "" {

            guard
                let imageData = UIImagePNGRepresentation(uploadImageView.image!) as? NSData,
                let title = inputTitle.text,
                let content = inputContent.text else { return }

            let timeToInteger = Int(Date().timeIntervalSince1970 * 1000.0)
            let timestamp = String(timeToInteger)

            let journal = Journal.init(imageData: imageData, title: title, content: content, timeStamp: timestamp)

            CoreDataProvider().saveJournal(withJournal: journal)

            self.navigationController?.popViewController(animated: true)

        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePlaceholder.isEnabled = false

        UIApplication.shared.statusBarStyle = .lightContent

        outletBtnCancel.layer.cornerRadius = 22

        addTapForImagePicker()

        imagePicker.delegate = self

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

    func addTapForImagePicker() {

        view.bringSubview(toFront: imageTapView)

        view.bringSubview(toFront: outletBtnCancel)

        view.bringSubview(toFront: imagePlaceholder)

        imageTapView.backgroundColor = UIColor.clear

        let tap = UITapGestureRecognizer(target: self, action: #selector(JournalViewController.pushImagePicker))

        imageTapView.addGestureRecognizer(tap)

    }

    func pushImagePicker() {

        imagePicker.sourceType = .photoLibrary

        present(imagePicker, animated: true, completion: nil)

    }

}

extension JournalViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {

        uploadImageView.image = pickedImage

            imagePlaceholder.isHidden = true

            remindLabel.isHidden = true

            isImageLoaded = true

        }

        dismiss(animated: true, completion: nil)

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        dismiss(animated: true, completion: nil)

    }

}
