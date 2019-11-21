//
//  NotesViewController.swift
//  TestApp
//
//

import UIKit

class NotesViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    

    // MARK: - Variables

    var presenter: INotesPresenter?
    var notes = [Note]()
    var filteredNotes = [Note]()
    var searchIsActive: Bool = false
    
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        NotesManager.getNotes(completionSuccess: { (notes) in
            self.notes = notes
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewNoteSegue" {
            self.resetSearch()
            let newNoteViewController = segue.destination as! NewNoteViewController
            newNoteViewController.delegate = self
        }
        
    }

}

// MARK: - UITableViewDelegate

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchIsActive ? self.filteredNotes.count : self.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.listTableView.dequeueReusableCell(withIdentifier: "ListCellIdentifier") as! ListTableViewCell

        let notes = self.searchIsActive ? self.filteredNotes : self.notes
        let note = notes[indexPath.row]
        cell.format(note)

        return cell
    }
}

// MARK: - UISearchBarDelegate

extension NotesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resetSearch()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        self.searchIsActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.searchIsActive = false
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            self.searchIsActive = false
        } else {
            self.filteredNotes = notes.filter({$0.body.lowercased().contains(searchText.lowercased())})
            self.searchIsActive = true
        }
        
        self.listTableView.reloadData()
    }
    
    func resetSearch() {
        self.searchBar.searchTextField.resignFirstResponder()
        self.searchBar.searchTextField.text = ""
        self.searchIsActive = false
        self.listTableView.reloadData()
    }
    
}

// MARK: - NewNoteViewControllerDelegate

extension NotesViewController: NewNoteViewControllerDelegate {
    
    func didAddNewNote(_ note: Note) {
        NotesManager.getNotes(completionSuccess: { (notes) in
            self.notes = notes
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        })
    }

}

