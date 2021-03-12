//
//  secondScreenViewController.swift
//  Flashcard
//
//  Created by Shakhram Gafurov on 3/6/21.
//

import UIKit

class secondScreenViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    
    var flashcardsController: firstScreenViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let alert = UIAlertController(title: "Uh oh", message: "Please enter both a question and an answer", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
                
        let questionText = questionTextField.text

        let answerText = answerTextField.text

        if (questionText == " " || answerText == " " || questionText!.isEmpty || answerText!.isEmpty) {
            present(alert, animated: true)
        } else {
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        dismiss(animated: true)
        }
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
}
