import UIKit
import RxSwift
/// LogIn screen. if user is already logged in redirect to home page.
class LogInViewController: UIViewController {
    
    private let userData = UserDefaults.standard
    private let auth = Auth()
    private var disposable: Disposable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (userData.string(forKey: "userToken") != nil && userData.string(forKey: "userSecret") != nil) {
            self.performSegue(withIdentifier: "showMain", sender: self)
        }
    }
    
    /// login in and authenticate user
    @IBAction func logIn(_ sender: UIButton) {
        disposable = auth.authUserToken()
            .subscribe(onError: { error in
                print(error)
            }, onCompleted: {
                print("completed")
                self.navigateToMain()
            }
        )
    }
    
    /// navigate to main screen.
    func navigateToMain() {
        disposable?.dispose()
        self.performSegue(withIdentifier: "showMain", sender: self)
    }
}
