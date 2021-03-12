//
//  ViewController.swift
//  Flashcard
//
//  Created by Shakhram Gafurov on 2/24/21.
//
import UIKit

class firstScreenViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var falseLabel: UILabel!
    
    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    //@IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    var hide:Bool = false;
    
    //gives round corners and borders to the labels/buttons
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
        
//        resetButton.layer.cornerRadius = 8.0;
//        resetButton.layer.borderWidth = 1.0;
//        resetButton.layer.borderColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        
        plusButton.layer.cornerRadius = 8.0;
        plusButton.layer.borderWidth = 1.0;
        plusButton.layer.borderColor = #colorLiteral(red: 0.1285564005, green: 0.3894066513, blue: 1, alpha: 1)
        
        editButton.layer.cornerRadius = 8.0;
        editButton.layer.borderWidth = 1.0;
        editButton.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        // Do any additional setup after loading the view.
    }

    //for the + button and pencil button
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! secondScreenViewController
        creationController.flashcardsController = self;
        
        if segue.identifier == "EditSegue"{
        creationController.initialQuestion = questionLabel.text;
        creationController.initialAnswer = answerLabel.text;
            //creationController.extraInitialAnswer1 =  optionOne.textInputContextIdentifier
        }
        
    }
    
    //for the large, main flashcard
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
    
    //updates main flashcard w/ custom Q & A created in
    //the second view controller
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?) {
        
        questionLabel.text = question;
        answerLabel.text = answer;
        
        optionOne.setTitle(extraAnswerOne, for: .normal)
        optionTwo.setTitle(answer, for: .normal)
        optionThree.setTitle(extraAnswerTwo, for: .normal)
        
        answerLabel.isHidden = false;
        
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
    
//    @IBAction func reset(_ sender: Any) {
//        questionLabel.isHidden = false;
//        answerLabel.isHidden = true;
//        falseLabel.isHidden = true;
//    }
}
