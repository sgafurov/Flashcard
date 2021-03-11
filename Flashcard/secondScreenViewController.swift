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
    
    var flashcardsController : firstScreenViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
//random comment...
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text

        let answerText = answerTextField.text
        
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
}
