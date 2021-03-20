//
//  secondScreenViewController.swift
//  Flashcard
//
//  Created by Shakhram Gafurov on 3/6/21.
//

import UIKit

class secondScreenViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var extraAnswerTextField1: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraAnswerTextField2: UITextField!
    
    /**
     * takes the questions and answers we had in the first view controller and pre-loads it into the Text Fields on the edit screen
     */
    var initialQuestion: String?
    var initialAnswer: String?
    var extraInitialAnswer1: String?
    var extraInitialAnswer2: String?
    
    var flashcardsController: firstScreenViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        extraAnswerTextField1.text = extraInitialAnswer1
        extraAnswerTextField2.text = extraInitialAnswer2
    }
    
    /**
     * provides error message for empty text fields
     * variables hold the String typed into the text fields
     * sends the String values in the text fields to the updateFlashcard method (of the first view controller) so we can see those txts as flashcards
     */
    @IBAction func didTapOnDone(_ sender: Any) {
        let alert = UIAlertController(title: "Uh oh", message: "Please enter both a question and an answer", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
                
        let questionText = questionTextField.text //this var holds whatever is typed into the question's text field

        let answerText = answerTextField.text //holds whatever is typed into the answer text field
        
        let extraanswerText1 = extraAnswerTextField1.text //for the first button
        
        let extraanswerText2 = extraAnswerTextField2.text //for the last button

        if (questionText == " " || answerText == " " || questionText!.isEmpty || answerText!.isEmpty) {
            present(alert, animated: true)
        } else {
            var isExisting = false;
            if initialQuestion != nil {
                isExisting = true
            }
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswerOne: extraanswerText1!, extraAnswerTwo: extraanswerText2!, isExisting: isExisting)
        dismiss(animated: true)
        }
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
}
