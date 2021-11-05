//
//  HelpViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol MyCustomCellDelegator {
    func callSegueFromCell(postInfo: Post)}

class HelpViewController: UIViewController, UICollectionViewDataSource, MyCustomCellDelegator {
    
    
    var currentPostInfo = Post(postuid: "", useruid: "", date: 0.0, subject: "", details: "", netid: "")
    
    func callSegueFromCell(postInfo: Post) {
        currentPostInfo = postInfo
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            let destinationvc = segue.destination as! DetailsViewController
            destinationvc.postInfo = currentPostInfo
        }
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let currentPost = arrayPosts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seek", for: indexPath as IndexPath) as! CollectionViewCell
        cell.subjectTitle.text = currentPost.subject
        cell.netidLabel.text = "by \(currentPost.netid)"
        cell.uid = currentPost.useruid
        cell.delegate = self
        cell.postinfo = currentPost
        cell.timeAgo.text = Date(timeIntervalSince1970: currentPost.date).timeAgoSinceDate()
        return cell
        
    }
    
    private let refreshControl = UIRefreshControl()

    
    override func viewDidAppear(_ animated: Bool) {
        if (Auth.auth().currentUser == nil){
            performSegue(withIdentifier: "toLogin", sender: self)
        }
    }
    
    @objc private func refreshFeed(_ sender: Any) {
    // Fetch Weather Data
    loadPosts()
    
}
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPosts()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        
        feedCollectionView.refreshControl = refreshControl
        refreshControl.tintColor = #colorLiteral(red: 0.4090681076, green: 0.1202988401, blue: 0.594352901, alpha: 1)
        refreshControl.addTarget(self, action: #selector(refreshFeed(_:)), for: .valueChanged)
        
        self.navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: "Futura Medium", size: 21) ?? UIFont(name: "Futura-Medium", size: 21) ?? UIFont.systemFont(ofSize: 21, weight: .medium)]

        feedCollectionView.dataSource = self
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        feedCollectionView.register(nib, forCellWithReuseIdentifier: "seek")
        
        let width = windowWidth() - 10
        let layout = feedCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: windowHeight()/7)
       
    }
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    let db = Firestore.firestore()
  
    func logoutUser(completion: (Bool) -> Void){
    
        do{
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch{
            print(error)
            completion(false)
            return
            
        }
        
        
    }
    
    var arrayPosts: [Post] = []
    
    func loadPosts(){
        arrayPosts = []
        db.collection("allPosts").document("academicSeeks").getDocument { [self] (snapshot, error) in
            if let e = error {
                print(e)
                self.refreshControl.endRefreshing()
            }
            else{
                
              

                

                let currentDocumentPostsArray = snapshot?.data()!["posts"] as! [String]

                    for post in currentDocumentPostsArray {
                        
                        if let currentPostDictionary = snapshot?.data()?[post] as? [String:Any] {

                            var currentPost = Post(postuid: currentPostDictionary["postUID"] as! String, useruid:  currentPostDictionary["userUID"] as! String, date:  currentPostDictionary["date"] as! Double, subject:  currentPostDictionary["subject"] as! String, details:  currentPostDictionary["details"] as! String, netid: currentPostDictionary["netid"] as! String)
                        
                        let uidOfPoster = currentPostDictionary["userUID"] as! String
                                                    
                        self.arrayPosts.append(currentPost)
                    }
                        
                    }
                
                print(arrayPosts)
                arrayPosts.reverse()
                feedCollectionView.reloadData()
                self.refreshControl.endRefreshing()

                    
             

                
            }
        }
    }
}
