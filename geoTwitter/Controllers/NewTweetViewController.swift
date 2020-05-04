import UIKit
/// Post a new tweet from logged in account
class NewTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var inputText: UITextView!
    private let api = TwitterApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInputField()
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
        inputText.text = "..."
        inputText.textColor = UIColor.lightGray
    }
    
    func setUpInputField(){
        inputText.delegate = self
        inputText.layer.borderColor = UIColor.systemTeal.cgColor
        inputText.layer.borderWidth = 1
        setPlaceholder()
    }
}
