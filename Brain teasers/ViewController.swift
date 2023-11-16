//
//  ViewController.swift
//  Brain teasers
//
//  Created by 凱聿蔡凱聿 on 2023/9/22.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var x1: UIImageView!
    @IBOutlet weak var x2: UIImageView!
    
    var count = 0
    var qaArray: [Qa] = []
    var displayedQuestions: [Qa] = []
    var currentIndex = 0
    var isAnswerShown = false
    
    let questionsPerRound = 10
    
    func startNewRound() {
        if qaArray.isEmpty {
            // 如果 qaArray 為空，則顯示提示或採取其他適當的操作
            questionLabel.text = "沒有更多題目了"
            answerLabel.text = ""
            countLabel.text = ""
            return
        }
        
        // 清空已經顯示過的問題
        displayedQuestions.removeAll()
        
        // 隨機抽取題目
        for _ in 0..<questionsPerRound {
            if currentIndex >= qaArray.count {
                // 如果已經超出 qaArray 的索引範圍，重新開始
                currentIndex = 0
            }
            
            let randomQuestion = qaArray[currentIndex]
            displayedQuestions.append(randomQuestion)
            currentIndex += 1
        }
        
        // 更新 count 變數
        count = 0
        
        // 顯示第一個問題
        showCurrentQuestion()
    }
    
    func showCurrentQuestion() {
        if count < displayedQuestions.count {
            let currentQuestion = displayedQuestions[count]
            questionLabel.text = currentQuestion.question
            answerLabel.text = currentQuestion.answer
            countLabel.text = "\(count + 1) / \(questionsPerRound)"
            
            // 將答案設定為隱藏
            answerLabel.isHidden = true
        } else {
            // 已經顯示完畢所有問題，開始新一輪
            startNewRound()
        }
    }
    
    
    @IBAction func answerBtn(_ sender: UIButton) {
        if isAnswerShown {
            x1.isHidden = false
            x2.isHidden = true
            answerLabel.isHidden = true
        } else {
            x1.isHidden = true
            x2.isHidden = false
            answerLabel.isHidden = false
        }
        
        // 切換 isAnswerShown 狀態
        isAnswerShown = !isAnswerShown
    }
    
    
    @IBAction func nextBtn(_ sender: UIButton) {
        count += 1
        showCurrentQuestion()
        x1.isHidden = false
        x2.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        x1.isHidden = false
        qaArray = QaData.qaArray
        answerLabel.isHidden = true // 將答案初始化為隱藏
        startNewRound()
    }
}
