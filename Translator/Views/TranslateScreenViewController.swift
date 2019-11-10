//
//  ViewController.swift
//  Translator
//
//  Created by Tianid on 05.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class TranslateScreenViewController: UIViewController {

    @IBOutlet weak var switchLanguageButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var inputTextTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var translateTextViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var inputTextTextView: UITextView!
    @IBOutlet weak var translateTextView: UITextView!

    @IBOutlet weak var inputTextLabel: UILabel!
    @IBOutlet weak var translateLabel: UILabel!
    
    @IBOutlet weak var leftLanguageLabel: UILabel!
    @IBOutlet weak var rightLanguageLabel: UILabel!

    private let scrollViewInsets: CGFloat = 45
    private var currentTranslationType: TranslateLanguage = .fromEnToRu
    private var presenter: TranslateScreenPresenterProtocol = TranslateScreenPresenter()
    
    private var contentHeight: CGFloat {
        return translateTextViewHeightConstraint.constant + inputTextTextViewHeightConstraint.constant + leftLanguageLabel.frame.height + inputTextLabel.frame.height + translateLabel.frame.size.height + scrollViewInsets
    }

   
    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentViewHeightConstraint.constant = contentHeight
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentHeight)
    }
    
    private func setup() {
        presenter.translateScreenViewController = self
        switchLanguageButton.addTarget(self, action: #selector(swap), for: .touchUpInside)
        leftLanguageLabel.text = "English"
        rightLanguageLabel.text = "Russian"
        inputTextTextView.delegate = self
        translateTextView.delegate = self
        inputTextTextView.layer.cornerRadius = 4
        translateTextView.layer.cornerRadius = 4
        inputTextTextView.layer.borderWidth = 0.5
        translateTextView.layer.borderWidth = 0.5
    }
    
    @IBAction func pushButton(_ sender: UIButton) {
        let editVC = EditViewController()
        present(editVC, animated: true, completion: nil)
        
    }
    @objc private func swap() {
        if currentTranslationType == .fromEnToRu {
            currentTranslationType = .fromRuToEn
        } else {
            currentTranslationType = .fromEnToRu
        }
        swapLanguageLabels()
        swapTextViewsText()
    }
    
    
    private func swapLanguageLabels() {
        let temp = leftLanguageLabel.text
        leftLanguageLabel.text = rightLanguageLabel.text
        rightLanguageLabel.text = temp
    }
    
    private func swapTextViewsText() {
        let temp = inputTextTextView.text
        inputTextTextView.text = translateTextView.text
        translateTextView.text = temp
    }
}

extension TranslateScreenViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard !textView.text.isEmpty else {
            setTranslateTextViewWithDefaultValues()
            return
        }
        setNewConstraintsValue(textView)
        if textView == inputTextTextView {
            presenter.getTranslate(text: textView.text, translateLanguageType: currentTranslationType)
        }
    }
    
    private func setTranslateTextViewWithDefaultValues() {
        translateTextView.text = nil
        inputTextTextViewHeightConstraint.constant = 33
        translateTextViewHeightConstraint.constant = 33
    }
    
    
    private func setNewConstraintsValue(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
            
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame
        
        inputTextTextViewHeightConstraint.constant = newSize.height
        translateTextViewHeightConstraint.constant = newSize.height
        
        contentViewHeightConstraint.constant = contentHeight

//        inputTextHeigthConstraint.constant = newSize.height
        
//        if textView == inputTextTextView {
//            inputTextTextViewHeightConstraint.constant = newSize.height
//        } else {
//            translateTextViewHeightConstraint.constant = newSize.height
//        }
                
    }
}

extension TranslateScreenViewController: TranslateScreenProtocol {
    
    func setupTranslateTextView(_ text: String?) {
        guard let text = text else { return }
        translateTextView.text = text
        setNewConstraintsValue(inputTextTextView)
    }
}


