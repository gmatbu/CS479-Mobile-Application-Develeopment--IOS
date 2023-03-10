//
//  Questions.swift
//  AreYouCorona?
//
//  Created by Gizem Melisa Ates on 5/2/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import Foundation

class Question{
    var QuizPrompt: String;
    var Answers: [String];
    
    init(QuizPrompt: String, Answers: [String]) {
        self.QuizPrompt = QuizPrompt;
        self.Answers = Answers;
    }
}

let Prompt: [String] =
[
    "How old are you?",
    "How many of the following symptoms you have recently started experiencing: fever or chills, difficulty breathing, cough, sore throat, vomitting or diarrhea, aching throughout the body?",
    "How many of the following apply to you: asthma or lung disease, cancer treatment or medicines causing immune suppression, inherited immune system deficiencies, heart conditions, diabetes, kidney failure?",
    "In the last 14 days, have you traveled internationally?",
    "In the last 14 days, what is your exposure to others who are known to have COVID-19?",
    "Do you work in a medical facility?"
];

let Answers: [[String]] =
[
    ["Under 18", "Between 18 and 40", "Between 40 and 65", "65 or older"],
    ["None of the above", "0-2", "3-5", "All of the above"],
    ["None of the above", "0-2", "3-5", "All of the above"],
    ["I have not travelled internationally", "I am not sure", "I have been in contact to a person who traveled internationally", "I have travelled internationally"],
    ["I've had no exposure", "I've been near someone who has COVID-19", "I've had close contact with someone who has COVID-19", "I live with someone who has COVID-19"],
    ["I don't work or plan to work in a medical facility", "I've been in contact with a medical worker", "I plan to work in a hospital in the nexy 14 days", "I've worked in a hospital in the past 14 days"]
];
