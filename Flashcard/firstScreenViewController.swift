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
    @IBOutlet weak var popUpLabel: UILabel!
    
    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    
    @IBOutlet weak var plusButton: UIButton! //DIMENSIONS= W:78 H:51
    @IBOutlet weak var editButton: UIButton! //DIMENSIONS= W:78 H:51
    @IBOutlet weak var deleteButton: UIButton! // W: 78 H: 49
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    
    var flashcards = [Flashcard]() //array to hold all flashcards structs
    var currentIndex = 0 //to track the current flashcard index...0 is the first index in the array
    var hide:Bool = false;
    var correctAnswerButton: UIButton! //remember which one was the correct answer
    
    /**
     * gives round corners and borders to the labels/buttons
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpLabel.isHidden = true;
        hide = true;
        
        card.layer.cornerRadius = 20.0;
        card.clipsToBounds = true; 
        
        questionLabel.layer.cornerRadius = 20.0;
        questionLabel.clipsToBounds = true;
        questionLabel.layer.borderWidth = 3.0;
        questionLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        falseLabel.layer.cornerRadius = 20.0;
        falseLabel.clipsToBounds = true;
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
        
        editButton.layer.cornerRadius = 8.0;
        editButton.layer.borderWidth = 1.0;
        editButton.layer.borderColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        deleteButton.layer.cornerRadius = 8.0;
        deleteButton.layer.borderWidth = 1.0;
        deleteButton.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        readSavedFlashcards();
        
        if flashcards.count == 0 {
            updateFlashcard(question: "When was the first iPhone released in the United States?", answer: "June 29, 2007", extraAnswerOne: "July 9, 2008", extraAnswerTwo: "January 3, 2007", isExisting: false);
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    //makes the items bounce-in when app first opens
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        //first, start with the flashcard looking invisible and smaller in size
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        optionOne.alpha = 0.0
        optionOne.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        optionTwo.alpha = 0.0
        optionTwo.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        optionThree.alpha = 0.0
        optionThree.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        //animation
        UIView.animate(withDuration: 0.9, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.card.alpha = 1
            self.card.transform = CGAffineTransform.identity
            
            self.optionOne.alpha = 1
            self.optionOne.transform = CGAffineTransform.identity
            
            self.optionTwo.alpha = 1
            self.optionTwo.transform = CGAffineTransform.identity
            
            self.optionThree.alpha = 1
            self.optionThree.transform = CGAffineTransform.identity
        })
    }
    
    /**
     * for when we click on the PLUS or PENCIL button
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! secondScreenViewController
        creationController.flashcardsController = self;
        
        //sets the question label to be the first and only label you see when you press DONE button.
        questionLabel.isHidden = false
        answerLabel.isHidden = true
        falseLabel.isHidden = true
        
        if segue.identifier == "EditSegue"{
            optionOne.isEnabled = true;
            optionTwo.isEnabled = true;
            optionThree.isEnabled = true;
            
            //sending what we have in our flashcard screen to pre-fill the text fields in the editing screen
            creationController.initialQuestion = questionLabel.text;
            creationController.initialAnswer = answerLabel.text;
            
            creationController.initialAnswer =  optionOne.titleLabel?.text
            creationController.extraInitialAnswer1 =  optionTwo.titleLabel?.text
            creationController.extraInitialAnswer2 =  optionThree.titleLabel?.text
            
            
//            if optionOne == correctAnswerButton{
//                creationController.initialAnswer =  optionOne.titleLabel?.text
//            } else {
//                creationController.initialAnswer =  optionOne.titleLabel?.text
//            }
//
//            if optionTwo == correctAnswerButton{
//                creationController.initialAnswer =  optionTwo.titleLabel?.text
//            } else {
//                creationController.extraInitialAnswer1 =  optionTwo.titleLabel?.text
//            }
//
//            if optionThree == correctAnswerButton{
//                creationController.initialAnswer =  optionThree.titleLabel?.text
//            } else {
//                creationController.extraInitialAnswer2 =  optionThree.titleLabel?.text
//            }
            
        }
    }
    
    /**
     * updates the big flashcard with custom Q & A values created in the second view controller.
     * creates a Flashcard object, updates the labels, and appends the Flashcard to our array.
     * the function we want to call when the app starts.
     */
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String, extraAnswerTwo: String, isExisting: Bool) {
        
        let flashcard = Flashcard(question: question, answer: answer, extraAnswerOne: extraAnswerOne, extraAnswerTwo: extraAnswerTwo) //creating flashcard object
        
        // questionLabel.text = flashcard.question; //the front part of the label
        // answerLabel.text = flashcard.answer; //the flipside of the label
        
        // optionOne.setTitle(flashcard.extraAnswerOne, for: .normal) //the first button on the screen
        // optionTwo.setTitle(flashcard.answer, for: .normal) //the middle button (that has the correct answer)
        // optionThree.setTitle(flashcard.extraAnswerTwo, for: .normal) //the last button
        
        if isExisting {
            //replace the existing flashcard
            flashcards[currentIndex] = flashcard
        } else {
            flashcards.append(flashcard) //appending the flashcard object we created above in this method, into the array
            print("I added a new flashcard!")
            print("I now have \(flashcards.count) flashcard!")
            currentIndex = flashcards.count-1
            print("Our current index is \(currentIndex)")
        }
        //updates the prev and next buttons everytime we add a flashcard
        updateNextPrevButtons();
        updateLabels();
        saveAllFlashcardsToDisk()
        
        //makes all answer buttons enabled once you tap on the edit button
        optionOne.isEnabled = true
        optionTwo.isEnabled = true
        optionThree.isEnabled = true
    }
    
    func updateNextPrevButtons(){
        //diables the next button if we are at end of flashcard array
        if(currentIndex == flashcards.count-1){
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        //diables the prev button if we are only at beginning of flashcard array
        if(currentIndex == 0){
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels(){
        //get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //update our labels
        questionLabel.text = currentFlashcard.question
        answerLabel.text = currentFlashcard.answer;
        
        //put our multiple choice buttons in an array and shuffle them + Update Them
        let buttons = [optionOne,optionTwo,optionThree].shuffled()
        let answers = [currentFlashcard.answer, currentFlashcard.extraAnswerOne, currentFlashcard.extraAnswerTwo].shuffled()
        
        for (button, answer) in zip(buttons, answers){
            //set the title of this random button with a random answer
            button?.setTitle(answer, for: .normal)
            
            //check if this is the correct answer. if so, save the button
            if answer == currentFlashcard.answer{
                correctAnswerButton = button
            }
        }
        //        optionOne.setTitle(currentFlashcard.extraAnswerOne, for: .normal) //the first button on the screen
        //        optionTwo.setTitle(currentFlashcard.answer, for: .normal) //the middle button (that has the correct answer)
        //        optionThree.setTitle(currentFlashcard.extraAnswerTwo, for: .normal) //the last button
    }
    
    /**
     * save our array of flashcards to the disk.
     */
    func saveAllFlashcardsToDisk(){
        //saves array on disk
        //UserDefaults.standard.set(flashcards, forKey: "flashcards")
        
        //from flashcard aaray to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "optionOne": card.extraAnswerOne, "optionThree": card.extraAnswerTwo]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        //log it
        print("Flashcards saved to UserDefaults!!!")
    }
    
    /**
     * What we want is to first read previously saved flashcards (if any).
     */
    func readSavedFlashcards(){
        //check for existing flashcards stored in UserDefaults
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAnswerOne: dictionary["optionOne"]!, extraAnswerTwo: dictionary["optionThree"]!)
            }
            
            //put all these cards in our flashcard array
            flashcards.append(contentsOf: savedCards)
            
        }
    }
    
    /**
     * when we click on the big main flashcard to see Q and A.
     */
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard();
        popUpLabel.isHidden=true;
    }
    
    func flipFlashcard(){
        
        UIView.transition(with: card, duration: 0.25, options: .transitionFlipFromRight, animations: {
            if (self.hide == false){
                self.questionLabel.isHidden = false;
                self.answerLabel.isHidden = true;
                self.hide = true;
            } else if(self.hide == true){
                self.questionLabel.isHidden = true;
                self.answerLabel.isHidden = false;
                self.hide = false;
            }
        })
        
    }
    
    func flipFlashcardOnce(){
        
        UIView.transition(with: card, duration: 0.25, options: .transitionFlipFromRight, animations: {
            self.questionLabel.isHidden = true
            self.answerLabel.isHidden = false;
            self.falseLabel.isHidden = true;
        })
        
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        popUpLabel.isHidden = true;
        
        //if correct answer chosen, flip the flaashcard. if not, disable the button
        if optionOne == correctAnswerButton{
            hide = false;
            flipFlashcardOnce()
            popUpLabel.isHidden = false;
            animatePopUpLabel()
        } else {
            questionLabel.isHidden = false;
            optionOne.isEnabled = false;
        }
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        popUpLabel.isHidden = true;
        
        //if correct answer chosen, flip the flaashcard. if not, disable the button
        if optionTwo == correctAnswerButton{
            hide = false;
            flipFlashcardOnce()
            popUpLabel.isHidden = false;
            animatePopUpLabel()
        } else {
            questionLabel.isHidden = false;
            optionTwo.isEnabled = false;
        }
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        popUpLabel.isHidden = true;
        
        //if correct answer chosen, flip the flaashcard. if not, disable the button
        if optionThree == correctAnswerButton{
            hide = false;
            flipFlashcardOnce()
            popUpLabel.isHidden = false;
            animatePopUpLabel()
        } else {
            questionLabel.isHidden = false;
            optionThree.isEnabled = false;
        }
        
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        questionLabel.isHidden = false
        answerLabel.isHidden = true
        falseLabel.isHidden = true
        popUpLabel.isHidden = true;
        animatePopUpLabelDown();
        
        //this is so the disabled buttons on the prev screen dont stay disabled on next screen
        optionOne.isEnabled = true
        optionTwo.isEnabled = true
        optionThree.isEnabled = true
        
        currentIndex = currentIndex + 1;
        
        updateNextPrevButtons();
        animateCardOutNext(); //animates cards when you press next
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        questionLabel.isHidden = false
        answerLabel.isHidden = true
        falseLabel.isHidden = true
        popUpLabel.isHidden = true;
        animatePopUpLabelDown();
        
        //this is so the disabled buttons on the next screen dont stay disabled on prev screen
        optionOne.isEnabled = true
        optionTwo.isEnabled = true
        optionThree.isEnabled = true
        
        currentIndex = currentIndex - 1;
        
        updateNextPrevButtons();
        animateCardOutPrev(); //animates cards when you press prev
    }
    
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard(){
        //delete current flashcard
        flashcards.remove(at: currentIndex)
        print("❌ flashcard was removed")
        
        //if last card was deleted, update the current card index to reflect correct count-1
        if currentIndex > flashcards.count-1{
            currentIndex = flashcards.count-1
        }
        //if we delete the only flashcard in the app, set currentIndex to 0 and fill flashcard with generic texts
        if flashcards.count == 0 {
            currentIndex = 0;
            updateFlashcard(question: "Enter some text", answer: " ", extraAnswerOne: " ", extraAnswerTwo: " ", isExisting: false);
            optionOne.isEnabled=false;
            optionTwo.isEnabled=false;
            optionThree.isEnabled=false;
            answerLabel.isHidden=true;
        }
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    func animateCardOutNext(){
        UIView.animate(withDuration: 0.15, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300, y: 0)
            self.optionOne.transform = CGAffineTransform.identity.translatedBy(x: -300, y: 0)
            self.optionTwo.transform = CGAffineTransform.identity.translatedBy(x: -300, y: 0)
            self.optionThree.transform = CGAffineTransform.identity.translatedBy(x: -300, y: 0)
        }, completion: { finished in
            self.updateLabels()
            self.animateCardInNext()
        })
    }
    func animateCardInNext(){
        
        //start on the right side and dont animate this
        card.transform  = CGAffineTransform.identity.translatedBy(x: 300, y: 0)
        optionOne.transform = CGAffineTransform.identity.translatedBy(x: 300, y: 0)
        optionTwo.transform = CGAffineTransform.identity.translatedBy(x: 300, y: 0)
        optionThree.transform = CGAffineTransform.identity.translatedBy(x: 300, y: 0)
        
        //animate card going back to original position
        UIView.animate(withDuration: 0.15){
            self.card.transform = CGAffineTransform.identity
            self.optionOne.transform = CGAffineTransform.identity
            self.optionTwo.transform = CGAffineTransform.identity
            self.optionThree.transform = CGAffineTransform.identity
        }
    }
    
    func animateCardOutPrev(){
        UIView.animate(withDuration: 0.15, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: 300, y: 0)
            self.optionOne.transform = CGAffineTransform.identity.translatedBy(x: 300, y: 0)
            self.optionTwo.transform = CGAffineTransform.identity.translatedBy(x: 300, y: 0)
            self.optionThree.transform = CGAffineTransform.identity.translatedBy(x: 300, y: 0)
        }, completion: { finished in
            self.updateLabels()
            self.animateCardInPrev()
        })
    }
    func animateCardInPrev(){
        
        //start on the right side and dont animate this
        card.transform  = CGAffineTransform.identity.translatedBy(x: -300, y: 0)
        optionOne.transform = CGAffineTransform.identity.translatedBy(x: -300, y: 0)
        optionTwo.transform = CGAffineTransform.identity.translatedBy(x: -300, y: 0)
        optionThree.transform = CGAffineTransform.identity.translatedBy(x: -300, y: 0)
        
        //animate card going back to original position
        UIView.animate(withDuration: 0.15){
            self.card.transform = CGAffineTransform.identity
            self.optionOne.transform = CGAffineTransform.identity
            self.optionTwo.transform = CGAffineTransform.identity
            self.optionThree.transform = CGAffineTransform.identity
        }
    }
    
    func animatePopUpLabel(){
        UIView.animate(withDuration: 0.25, animations: {
            self.popUpLabel.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -17)
        })
    }
    
    func animatePopUpLabelDown(){
        UIView.animate(withDuration: 0.25, animations: {
            self.popUpLabel.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 17)
        })
    }
    
    
} //end of program
