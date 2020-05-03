
import Foundation

class MyMessages {
    
    var account: Account
    var messages: [Event] = []
    
    init(account: Account) {
        self.account = account
    }
    
}
