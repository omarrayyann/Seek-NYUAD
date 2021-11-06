//
//  MentalUIViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 06/11/2021.
//

import UIKit
import FirebaseFirestore
import BonsaiController


protocol MyCustomCellDelegatorTwo {
    func callSegueFromCell(listenerInfo: Listener)}

class MentalUIViewController: UIViewController, UICollectionViewDataSource, MyCustomCellDelegatorTwo, UIViewControllerTransitioningDelegate {
    
    
    func callSegueFromCell(listenerInfo: Listener) {
        
        let smallVC = storyboard!.instantiateViewController(identifier: "contact") as! ContactViewController
        smallVC.transitioningDelegate = self
        smallVC.uid = listenerInfo.uid
        smallVC.modalPresentationStyle = .custom
            present(smallVC, animated: true, completion: nil )


    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayListners.count
    }
    
    private let refreshControl = UIRefreshControl()

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentListener = arrayListners[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listener", for: indexPath as IndexPath) as! ListenersCollectionViewCell
        cell.name.text = currentListener.fullName
        cell.netid.text = currentListener.netid
        cell.listenerInfo = currentListener
        cell.classOF.text = "Class of \(currentListener.classOf)"
        cell.delegate = self
        return cell
    }
    
    
    var arrayListners: [Listener] = []
    
    @objc private func refreshFeed(_ sender: Any) {
    // Fetch Weather Data
    loadListeners()
    
}
    

    @IBOutlet weak var listenersCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        listenersCollectionView.dataSource = self
        loadListeners()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let width = windowWidth() - 10
        let layout = listenersCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: 115)
        
        listenersCollectionView.refreshControl = refreshControl
        refreshControl.tintColor = #colorLiteral(red: 0.4090681076, green: 0.1202988401, blue: 0.594352901, alpha: 1)
        refreshControl.addTarget(self, action: #selector(refreshFeed(_:)), for: .valueChanged)
        
        self.navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: "Futura Medium", size: 21) ?? UIFont(name: "Futura-Medium", size: 21) ?? UIFont.systemFont(ofSize: 21, weight: .medium)]
        // Do any additional setup after loading the view.
    }
    
    let db = Firestore.firestore()

    func loadListeners(){
        
    
        arrayListners = []
        db.collection("Listeners").document("listeners").getDocument { snapshot, error in
            if let e = error {
                print(e)
                self.refreshControl.endRefreshing()
            }
            else{
                var arrayOfListenrsUID = snapshot?.data()!["listeners"] as! [String]
                
                for listener in arrayOfListenrsUID {
                 
                    self.db.collection("Users").document(listener).getDocument { snapshot, error in
                        if let e = error {
                            print(e)
                        }
                        else{
                            var newListener = Listener(fullName: snapshot?.data()!["fullName"] as! String, uid: snapshot?.data()!["uid"] as! String, netid: snapshot?.data()?["netid"] as! String, classOf: snapshot?.data()?["classof"] as! String, instagram: snapshot?.data()?["instagram"] as! String, whatsapp: snapshot?.data()?["whatsapp"] as! String)
                            self.arrayListners.append(newListener)
                        }
                        print(self.arrayListners)
                        self.refreshControl.endRefreshing()
                        self.listenersCollectionView.reloadData()
                        
                    }
                 
                }
                
                
            }
        }
        
        
    }
 

}


extension MentalUIViewController: BonsaiControllerDelegate {

// return the frame of your Bonsai View Controller
func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {

return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 2), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / 2))
}

// return a Bonsai Controller with SlideIn or Bubble transition animator
func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {

/// With Background Color ///

// Slide animation from .left, .right, .top, .bottom
return BonsaiController(fromDirection: .bottom, backgroundColor: UIColor(white: 0, alpha: 0.5), presentedViewController: presented, delegate: self)

// or Bubble animation initiated from a view
//return BonsaiController(fromView: yourOriginView, backgroundColor: UIColor(white: 0, alpha: 0.5), presentedViewController: presented, delegate: self)


/// With Blur Style ///

// Slide animation from .left, .right, .top, .bottom
//return BonsaiController(fromDirection: .bottom, blurEffectStyle: .light, presentedViewController: presented, delegate: self)

// or Bubble animation initiated from a view
//return BonsaiController(fromView: yourOriginView, blurEffectStyle: .dark,  presentedViewController: presented, delegate: self)
}


}
