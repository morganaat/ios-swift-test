AlayaCare iOS Swift skill test
===============================


### What's included
The repo contains a skeleton iOS application created using Xcode 10.1. The app contains a couple of empty files to start you off:
* NotesPresenter: An empty presenter to manage the controller.
* NotesController: An empty controller to display a list of notes. 
* Note: An empty data model to represent a note entity. 
* Main.storyboard: A storyboard containing an empty view for the note controller.

### Requirements
* Xcode 10+
* A Github account

### Installation
* Fork this repository
* Open the directory in Xcode 10
* The app should build and run if all requirements are met

### Instructions
The goal of this exercise is to create a very simple note app by following the tasks below. 

Try to have each commit represent a completed task.

Code should be:
* easy to read
* follow a consistent style guide
* modular
* tested if possible

Note: The skeleton is using MVP architecture.

First fork this repository, then commit your changes and create a pull request when you're done (See [How to submit your work?](#how-to-submit-your-work)). 
The provided files can be used as a guideline, but add or remove whatever other files you need. 


* TASK 1: Create a data source for the notes:
  * create a note model that can capture the text entered by a user and the date the user created the note
  * create a simple mock data source to return a list of fake notes asynchronously

* TASK 2: Display a table of notes:
  * use the mock API to populate the list
  * each list item should display the note text and date

* TASK 3: Implement logic for creating a new note:
  * do this however you want
  * storage can be in memory 
  * note text should not be empty
  * new notes should appear in the table of notes created in Task 2

* TASK 4: Add search functionality to your list of notes:
  * search should support matching to any part of the note text

* OPTIONAL TASK 5: Save, edit and delete notes
  * use CoreData to persist the notes
  * remove your mock data source and save new notes to CoreData
  * add an option to edit and delete a note from the list


### How to submit your work?

1. ##### First you need to fork this repository.
![Forking a repo](/web/img/fork.png?raw=true "Forking a repo")

2. ##### Then clone your fork locally.
![Cloning a repo](/web/img/clone.png?raw=true "Cloning a repo")

3. ##### Install the app locally. See the [Installation Guide] (#Installation).

4. ##### Once you've completed your work, you can submit a pull-request to the remote repository.
![ a Pull Request](/web/img/pull-request.png?raw=true "Creating a Pull Request")

5. ##### Review your changes and validate.
![Validating a Pull Request](/web/img/pull-request-review.png?raw=true "Validating a Pull Request")



And you're done!


More documentation on Github:
* https://help.github.com/articles/fork-a-repo/
* https://help.github.com/articles/using-pull-requests/
