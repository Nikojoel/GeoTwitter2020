/**
 Tableview controller for displaying list of tweets with user inputed search string
 */
import UIKit
import RxSwift
import Kingfisher

class TweetTableViewController: UITableViewController {
    
    @IBOutlet var tweetTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var showMapButton: UIBarButtonItem!
    
    private let twitterApi = TwitterApi()
    private let disposeBag = DisposeBag()
    private var disposable: Disposable?
    private var tweets: [TweetQuery] = [] {
        didSet {
            tableView.reloadData()
            loadingIndicator.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        disposable?.disposed(by: disposeBag)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tweetIndex = tableView.indexPathForSelectedRow else { return }
        if let destination = segue.destination as? SingleTweetController {
            destination.tweet = tweets[tweetIndex.section].tweet[tweetIndex.row]
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tweets.count
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets[section].tweet.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        let tweet = tweets[indexPath.section].tweet[indexPath.row]
        if let img = tweet.user.profile_image_url_https {
           cell.profileImage.kf.setImage(with: URL(string: img))
        }
        
        cell.userName.text = tweet.user.name
        cell.tweetText.text = tweet.text
        return cell
    }
}

    //MARK: - Searchbar delegate
extension TweetTableViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        loadingIndicator.isHidden = false
        if let text = searchBar.text {
            disposable = twitterApi.searchTweet(text)
                .subscribe({ [weak self] in
                    if let result = $0.element {
                        self?.tweets.insert(result, at: 0)
                    }
            })
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}

    //MARK: - initial setup of view
extension TweetTableViewController {
    func initialSetup() {
       self.view.backgroundColor = .white
        loadingIndicator.isHidden = true
        searchBar.delegate = self
        tweetTableView.rowHeight = 95
        self.tableView.keyboardDismissMode = .onDrag
    }
}


