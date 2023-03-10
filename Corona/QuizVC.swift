//
//  QuestionVC.swift
//  AreYouCorona?
//
//  Created by Gizem Melisa Ates on 5/2/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit

class QuizVC: UIViewController {
      
    var questions = [Question]();
    var questionNum: Int = 0;
    var PlayerAnswers = [0, 0, 0, 0, 0, 0];
    
    @IBOutlet weak var QuestionNum: UILabel!
    
    @IBOutlet weak var PromptLabel: UILabel!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var prevbtn: UIButton!
    @IBOutlet weak var nextbtn: UIButton!
    @IBOutlet weak var resultsbtn: UIButton!
    
    @IBAction func prevTapped(_ sender: UIButton) {
        
        if questionNum == 1{
            prevbtn.isHidden = true
            prevHelp()
        }
        else if questionNum == 5{
            nextbtn.isHidden = false
            resultsbtn.isHidden = true
            prevHelp()
        }else{
            prevHelp()
        }
    }
    @IBAction func nextTapped(_ sender: UIButton) {
        print("question num \(questionNum)")
        if questionNum == 4 {
            nextbtn.isHidden = true
            if PlayerAnswers[5] != 0{
                resultsbtn.isHidden = false
            }
            prevbtn.isHidden = false
            nextHelp()
        }else{
            prevbtn.isHidden = false
            nextHelp()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prevbtn.isHidden = true
        nextbtn.isHidden = false
        resultsbtn.isHidden = true
        
        for i in 0..<Prompt.count{
            questions.append(Question(QuizPrompt: Prompt[i], Answers: Answers[i]));
        }
        
        loadQuestion()
        originalColors()
    }


    func loadQuestion(){
          PromptLabel.text = questions[questionNum].QuizPrompt;
          QuestionNum.text = "Question \(questionNum + 1)";
          for i in 0..<questions[questionNum].Answers.count{
              let answer: String = questions[questionNum].Answers[i];
              switch i{
              case 0: btn1.setTitle("a) \(answer)", for: .normal)
              case 1: btn2.setTitle("b) \(answer)", for: .normal)
              case 2: btn3.setTitle("c) \(answer)", for: .normal)
              case 3: btn4.setTitle("d) \(answer)", for: .normal)
              default: break;
              }
          }
    }

    func originalColors(){
        btn1.setTitleColor(UIColor.blue, for: .normal)
        btn2.setTitleColor(UIColor.blue, for: .normal)
        btn3.setTitleColor(UIColor.blue, for: .normal)
        btn4.setTitleColor(UIColor.blue, for: .normal)
    }
    
    func UpdateButtons(qnum: Int){
        helpUpdate(i: qnum)
    }
    
    
    @IBAction func Selected(_ sender: UIButton) {//didn't use
        if sender == btn1 {
            getAnswers(i: 0)
            print("players ans \(PlayerAnswers)")
            UpdateButtons(qnum: questionNum)
            if PlayerAnswers[5] == 0 {
                resultsbtn.isHidden = true
            }else{ resultsbtn.isHidden = false}
        }else if sender == btn2 {
            getAnswers(i: 1)
            print("players ans \(PlayerAnswers)")
            UpdateButtons(qnum: questionNum)
            if PlayerAnswers[5] == 0 {
                resultsbtn.isHidden = true
            }else{ resultsbtn.isHidden = false}
        }else if sender == btn3 {
            getAnswers(i: 2)
            print("players ans \(PlayerAnswers)")
            UpdateButtons(qnum: questionNum)
            if PlayerAnswers[5] == 0 {
                resultsbtn.isHidden = true
            }else{ resultsbtn.isHidden = false}
        }else{
            getAnswers(i: 3)
            print("players ans \(PlayerAnswers)")
            UpdateButtons(qnum: questionNum)
            if PlayerAnswers[5] == 0 {
                resultsbtn.isHidden = true
            }else{ resultsbtn.isHidden = false}
        }
    }
    
    func getAnswers(i: Int){
        if questionNum == 0 {
            PlayerAnswers[0] = i+1
        }else if questionNum == 1{
            PlayerAnswers[1] = i+1
        }else if questionNum == 2{
            PlayerAnswers[2] = i+1
        }else if questionNum == 3{
            PlayerAnswers[3] = i+1
        }else if questionNum == 4{
            PlayerAnswers[4] = i+1
        }else{
            PlayerAnswers[5] = i+1
        }
    }
    
    func getResults() -> String{
        if PlayerAnswers.reduce(0, +) <= 6{
            return "Your chance of getting infected by COVID-19 is minimum"
        }else if PlayerAnswers.reduce(0, +) <= 10{
            return "Your chance of getting infected by COVID-19 is medium"
        }else if PlayerAnswers.reduce(0, +) <= 16{
            return "Your chance of getting infected by COVID-19 is high"
        }else {
            return "Your chance of getting infected by COVID-19 is extremely-high"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let currentDate = Date()
        let dateNeeded = formatter.string(from: currentDate)

        
        if (segue.identifier == "QuizVCtoResultsVC"){
            let resultvc = segue.destination as! ResultsVC
            resultvc.message = self.getResults()
            resultvc.date = dateNeeded
        }
    }
    
    func helpUpdate(i: Int){
        if PlayerAnswers[i] == 1{
            btn1.setTitleColor(UIColor.green, for: .normal)
            btn2.setTitleColor(UIColor.blue, for: .normal)
            btn3.setTitleColor(UIColor.blue, for: .normal)
            btn4.setTitleColor(UIColor.blue, for: .normal)
        }else if PlayerAnswers[i] == 2{
            btn1.setTitleColor(UIColor.blue, for: .normal)
            btn2.setTitleColor(UIColor.green, for: .normal)
            btn3.setTitleColor(UIColor.blue, for: .normal)
            btn4.setTitleColor(UIColor.blue, for: .normal)
        }else if PlayerAnswers[i] == 3{
            btn1.setTitleColor(UIColor.blue, for: .normal)
            btn2.setTitleColor(UIColor.blue, for: .normal)
            btn3.setTitleColor(UIColor.green, for: .normal)
            btn4.setTitleColor(UIColor.blue, for: .normal)
        }else if PlayerAnswers[i] == 4{
            btn1.setTitleColor(UIColor.blue, for: .normal)
            btn2.setTitleColor(UIColor.blue, for: .normal)
            btn3.setTitleColor(UIColor.blue, for: .normal)
            btn4.setTitleColor(UIColor.green, for: .normal)
        }
    }
    
    func prevHelp(){
        questionNum -= 1
        PromptLabel.text = questions[questionNum].QuizPrompt;
        QuestionNum.text = "Question \(questionNum + 1)";
        loadQuestion()
        if PlayerAnswers[questionNum] == 0{
            originalColors()
        }else{
            UpdateButtons(qnum: questionNum)
        }
    }
    
    func nextHelp(){
        questionNum += 1
        PromptLabel.text = questions[questionNum].QuizPrompt;
        QuestionNum.text = "Question \(questionNum + 1)";
        loadQuestion()
        if PlayerAnswers[questionNum] == 0{
            originalColors()
        }else{
            UpdateButtons(qnum: questionNum)
        }
    }
}
