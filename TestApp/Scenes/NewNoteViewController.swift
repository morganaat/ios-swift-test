//
//  NewNoteViewController.swift
//  TestApp
//
//  Created by Morgana Timbo on 2019-11-19.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import UIKit

protocol NewNoteViewControllerDelegate {
    func didAddNewNote(_ note: Note)
}

class NewNoteViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var noteBodyTextView: UITextView!
    
    // MARK: - Variables
    
    private let date = Date()
    
    var delegate: NewNoteViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleTextView.delegate = self
        self.titleTextView.returnKeyType = .next
        self.titleTextView.isScrollEnabled = false
        self.titleTextView.text = ""
        self.titleTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.titleTextView.layer.borderWidth = 0.5
        self.titleTextView.layer.cornerRadius = 5
        
        self.noteBodyTextView.delegate = self
        self.noteBodyTextView.returnKeyType = .default
        self.noteBodyTextView.text = ""
        self.noteBodyTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.noteBodyTextView.layer.borderWidth = 0.5
        self.noteBodyTextView.layer.cornerRadius = 5

        self.timestampLabel.text = "\(date)"
        
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Empty Note", message: "Please enter a note.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func onSaveClicked(_ sender: Any) {
        
        if let bodyText = self.noteBodyTextView.text, bodyText.count > 0 {
            
            let newNote = Note(title: self.titleTextView.text ?? "", body: bodyText, timeStamp: date)
            SampleNotes.notes.append(newNote)
            self.delegate?.didAddNewNote(newNote)
            self.navigationController?.popViewController(animated: true)
        
        } else {
            self.showAlert()
        }
    }
    
}

// MARK: - UITextViewDelegate

extension NewNoteViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Set a maximum range of characters to titleTextView
        if textView == self.titleTextView {
            
            if textView.text.count >= 28 && range.length == 0 {
                
                // TODO: handle error
                // e.g.; shake textview or show alert or change textfield color to red
                return false
            }
        }
        
        return true
    }
}
