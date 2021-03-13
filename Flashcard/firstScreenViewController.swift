//
//  ViewController.swift
//  Flashcard
//
//  Created by Shakhram Gafurov on 2/24/21.
//
import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var extraAnswerOne: String
    var extraAnswerTwo: String
}

class firstScreenViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var falseLabel: UILabel!
    
    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    
    @IBOutlet weak var plusButton: UIButton! //DIMENSIONS= W:78 H:51
    @IBOutlet weak var editButton: UIButton! //DIMENSIONS= W:78 H:51
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    
    var flashcards = [Flashcard]() //array to hold all flashcards structs
    var currentIndex = 0 //to track the current flashcard index...0 is the first index in the array
    var hide:Bool = false;
    
    /**
     * gives round corners and borders to the labels/buttons
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius = 20.0;
        card.clipsToBounds = true;
        
        questionLabel.layer.cornerRadius = 20.0;
        questionLabel.layer.borderWidth = 3.0;
        questionLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        falseLabel.layer.cornerRadius = 20.0;
        falseLabel.layer.borderWidth = 3.0;
        falseLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        optionOne.layer.cornerRadius = 20.0;
        optionOne.layer.borderWidth = 3.0;
        optionOne.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        optionTwo.layer.cornerRadius = 20.0;
        optionTwo.layer.borderWidth = 3.0;
        optionTwo.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        optionThree.layer.cornerRadius = 20.0;
        optionThree.layer.borderWidth = 3.0;
        optionThree.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        plusButton.layer.cornerRadius = 8.0;
        plusButton.layer.borderWidth = 1.0;
        plusButton.layer.borderColor = #colorLiteral(red: 0.1285564005, green: 0.3894066513, blue: 1, alpha: 1)
        
        editButton.layer.cornerRadius = 8.0;
        editButton.layer.borderWidth = 1.0;
        editButton.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
    }

    
    /**
     * for when we click on the PLUS or PENCIL button
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! secondScreenViewController
        creationController.flashcardsController = self;
        
        //sets the question label to be the first label you see when you press DONE. you see the question label and not the previous answer you left off
        questionLabel.isHidden = false
        answerLabel.isHidden = true
        falseLabel.isHidden = true
        
        if segue.identifier == "EditSegue"{
            
        creationController.initialQuestion = questionLabel.text;
        creationController.initialAnswer = answerLabel.text;
            
            creationController.extraInitialAnswer1 =  optionOne.titleLabel?.text
            
            creationController.initialAnswer =  optionTwo.titleLabel?.text
           
            creationController.extraInitialAnswer2 =  optionThree.titleLabel?.text
        }
    }
    
    /**
     * when we click on the big main flashcard to see Q and A.
     */
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (hide == false){
        questionLabel.isHidden = false;
        answerLabel.isHidden = true;
        hide = true;
        } else if(hide==true){
        questionLabel.isHidden = true;
        answerLabel.isHidden = false;
        hide = false;
        }
    } 
    
    /**
     * updates the big flashcard with custom Q & A values created in the second view controller.
     * creates a Flashcard object, updates the labels, and appends the Flashcard to our array.
     * the function we want to call when the app starts.
     */
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String, extraAnswerTwo: String) {
        
        let flashcard = Flashcard(question: question, answer: answer, extraAnswerOne: extraAnswerOne, extraAnswerTwo: extraAnswerTwo) //creating flashcard object
        
        questionLabel.text = flashcard.question; //the front part of the label
        answerLabel.text = flashcard.answer; //the flipside of the label
        
        optionOne.setTitle(flashcard.extraAnswerOne, for: .normal) //the first button on the screen
        optionTwo.setTitle(flashcard.answer, for: .normal) //the middle button (that has the correct answer)
        optionThree.setTitle(flashcard.extraAnswerTwo, for: .normal) //the last button
                
        flashcards.append(flashcard) //appending the flashcard object we created above in this method, into the array
    }
    
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        questionLabel.isHidden = true;
        answerLabel.isHidden = true;
        falseLabel.isHidden = false;
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        questionLabel.isHidden = true;
        falseLabel.isHidden = true;
        answerLabel.isHidden = false;
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        questionLabel.isHidden = true;
        answerLabel.isHidden = true;
        falseLabel.isHidden = false;
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
    }

}
