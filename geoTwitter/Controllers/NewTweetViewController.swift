//
//  NewTweetViewController.swift
//  geoTwitter
//
//  Created by iosdev on 27.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var inputText: UITextView!
    private let api = TwitterApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInputField()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendTweet(_ sender: UIButton) {
        api.postTweet(message: inputText.text)
        setPlaceholder()
        print("message sent")
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func setPlaceholder() {
        inputText.text = "Are you sure the world wants to see this?"
        inputText.textColor = UIColor.lightGray
    }
    
    func setUpInputField(){
        inputText.delegate = self
        inputText.layer.borderColor = UIColor.systemTeal.cgColor
        inputText.layer.borderWidth = 1
        setPlaceholder()
    }
}
