//
//  NewNoteViewController.swift
//  TestApp
//
//  Created by Morgana Timbo on 2019-11-19.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import UIKit

protocol NewNoteViewControllerDelegate {
    func didUpdateNotes()
}

class NewNoteViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var noteBodyTextView: UITextView!
    
    // MARK: - Variables
    
    enum ViewMode {
        case newNote
        case editNote
    }
    
    var viewMode: ViewMode = .newNote
    var note: Note!
    var delegate: NewNoteViewControllerDelegate? = nil
    private var date: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.noteBodyTextView.delegate = self
        self.noteBodyTextView.returnKeyType = .default
        self.noteBodyTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.noteBodyTextView.layer.borderWidth = 0.5
        self.noteBodyTextView.layer.cornerRadius = 5
        self.noteBodyTextView.becomeFirstResponder()

        self.updateUI()
    }
    
    private func updateUI() {
        
        switch viewMode {
            
        case .editNote:
            guard let note = self.note else { return }
            self.date = note.date
            self.timestampLabel.text = self.date
            self.noteBodyTextView.text = note.noteText
        
        case .newNote:
            self.date = Date().formatTodaysDate()
            self.timestampLabel.text = self.date
            self.noteBodyTextView.text = ""
            
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Empty Note", message: "Please enter a note.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func onSaveClicked(_ sender: Any) {
        
        if let noteText = self.noteBodyTextView.text, noteText.count > 0 {
            
            
            switch viewMode {
                
            case .editNote:
                
                guard let currentNote = self.note else { return }
                
                NotesManager.updateData(currentNote: currentNote, newText: noteText, completionSuccess: {
                    self.delegate?.didUpdateNotes()
                    self.navigationController?.popViewController(animated: true)
                
                }, completionError:  { (error) in
                    // TODO: handle error(e.g; show alert)
                
                })

            
            case .newNote:
                
                let newNote = Note(noteText: noteText, date: self.date)
                
                NotesManager.createData(note: newNote, completionSuccess: {
                    self.delegate?.didUpdateNotes()
                    self.navigationController?.popViewController(animated: true)
                
                }, completionError:  { (error) in
                    // TODO: handle error(e.g; show alert)
                
                })

            }
            
        } else {
            self.showAlert()
        }
    }
    
}

// MARK: - UITextViewDelegate

extension NewNoteViewController: UITextViewDelegate {
    //
}

