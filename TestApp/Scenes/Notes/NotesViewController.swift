//
//  NotesViewController.swift
//  TestApp
//
//

import UIKit

class NotesViewController: UIViewController {

    // MARK: - Variables

    var presenter: INotesPresenter?
    
    var notes = [Note]()

    @IBOutlet weak var listTableView: UITableView!
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotesManager.getNotes(completionSuccess: { (notes) in
            self.notes = notes
            for note in notes {
                print (note.title)
                print (note.body)
                print (note.timeStamp)
                print ("\n")
            }
        })
    }


}

// MARK: - UITableViewDelegate

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.listTableView.dequeueReusableCell(withIdentifier: "ListCellIdentifier") as! ListTableViewCell

        let note = self.notes[indexPath.row]
        cell.format(note)

        return cell
    }
    
    
}

