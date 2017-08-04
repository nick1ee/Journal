//
//  Extensions.swift
//  Journal
//
//  Created by Nick Lee on 2017/8/4.
//  Copyright © 2017年 nicklee. All rights reserved.
//

import UIKit

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

extension JournalViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {

        if inputContent.text == "Content" {

            inputContent.text = ""

        }

    }

    func textViewDidEndEditing(_ textView: UITextView) {

        if inputContent.text.isEmpty {

            inputContent.text = "Content"

        }
    }

}

extension JournalViewController {

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

    func addImageSpotlight() {

        outletBtnCancel.layer.cornerRadius = 22

        imagePlaceholder.layer.shadowColor = UIColor.white.cgColor

        imagePlaceholder.layer.shadowOpacity = 1

        imagePlaceholder.layer.shadowOffset = CGSize(width: 0, height: 0)

        imagePlaceholder.layer.shadowRadius = 50.0

        imagePlaceholder.layer.cornerRadius = 40

        imagePlaceholder.layer.masksToBounds = false

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

}
