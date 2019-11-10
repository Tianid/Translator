//
//  EditViewController.swift
//  Translator
//
//  Created by Tianid on 10.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    private var russianLabel: UILabel!
    private var englishLabel: UILabel!
    private var russianTextView: UITextView!
    private var englishTextView: UITextView!
    private var scrollView: UIScrollView!
    private var viewForScrollView: UIView!
    
    private var viewForScrollInset: CGFloat {
        
        return englishLabel.frame.size.height + russianLabel.frame.size.height +  russianTextView.frame.size.height + englishTextView.frame.size.height + 36
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    private func setup() {
        let scrollViewRect = self.view.frame
        scrollView = UIScrollView(frame: scrollViewRect)
        scrollView.contentSize = CGSize(width: scrollViewRect.size.width, height: scrollViewRect.size.height)
        //        scrollView.backgroundColor = .red
        
        viewForScrollView = UIView()
        viewForScrollView.backgroundColor = #colorLiteral(red: 0.2041296959, green: 0.7789589763, blue: 0.3484356999, alpha: 1)
        //        viewForScrollView.layer.borderWidth = 1
        //        viewForScrollView.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        russianLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        englishLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        russianLabel.text = "Russian:"
        englishLabel.text = "English:"
        
        russianTextView = UITextView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        englishTextView = UITextView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        russianTextView.isScrollEnabled = false
        englishTextView.isScrollEnabled = false
        //        russianTextView.backgroundColor = .yellow
        //        russianTextView.layer.borderWidth = 5
        //        englishTextView.backgroundColor = .orange
        russianTextView.layer.borderWidth = 0.5
        englishTextView.layer.borderWidth = 0.5
        russianTextView.layer.cornerRadius = 4
        englishTextView.layer.cornerRadius = 4
        
        russianLabel.translatesAutoresizingMaskIntoConstraints = false
        englishLabel.translatesAutoresizingMaskIntoConstraints = false
        viewForScrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        russianTextView.translatesAutoresizingMaskIntoConstraints = false
        englishTextView.translatesAutoresizingMaskIntoConstraints = false
        
        viewForScrollView.addSubview(russianLabel)
        viewForScrollView.addSubview(englishLabel)
        viewForScrollView.addSubview(russianTextView)
        viewForScrollView.addSubview(englishTextView)
        
        scrollView.addSubview(viewForScrollView)
        
        view.addSubview(scrollView)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([viewForScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
                                     viewForScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: viewForScrollInset),
                                     viewForScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                                     viewForScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                                     viewForScrollView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([russianLabel.topAnchor.constraint(equalTo: viewForScrollView.topAnchor, constant: 1),
                                     russianLabel.leadingAnchor.constraint(equalTo: viewForScrollView.leadingAnchor, constant: 8),
                                     russianLabel.trailingAnchor.constraint(equalTo: viewForScrollView.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([russianTextView.topAnchor.constraint(equalTo: russianLabel.bottomAnchor, constant: 1),
                                     russianTextView.leadingAnchor.constraint(equalTo: viewForScrollView.leadingAnchor, constant: 8),
                                     russianTextView.trailingAnchor.constraint(equalTo: viewForScrollView.trailingAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([englishLabel.topAnchor.constraint(equalTo: russianTextView.bottomAnchor, constant: 1),
                                     englishLabel.leadingAnchor.constraint(equalTo: viewForScrollView.leadingAnchor, constant: 8),
                                     englishLabel.trailingAnchor.constraint(equalTo: viewForScrollView.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([englishTextView.topAnchor.constraint(equalTo: englishLabel.bottomAnchor, constant: 1),
                                     englishTextView.leadingAnchor.constraint(equalTo: viewForScrollView.leadingAnchor, constant: 8),
                                     englishTextView.trailingAnchor.constraint(equalTo: viewForScrollView.trailingAnchor, constant: -8),
                                     //                                          englishTextView.heightAnchor.constraint(equalToConstant: englishTextView.frame.size.height),
            viewForScrollView.bottomAnchor.constraint(equalTo: englishTextView.bottomAnchor, constant: 10)
        ])
    }
}
