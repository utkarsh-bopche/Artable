//
//  ViewController.swift
//  Artable
//
//  Created by Apple on 26/08/21.
//

import UIKit
import Firebase


class HomeVC: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //Variables
    var categories = [Category]()
    var selectedCategory : Category!
    let db = Firestore.firestore()
    var listner : ListenerRegistration!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Identifiers.CategoryCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.CategoryCell)
        // Do any additional setup after loading the view.
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result,error) in
                if let error = error {
                    Auth.auth().handleFireAuthError(error: error , vc: self)
                    debugPrint(error)
                }
            }
        }
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        setCategoriesListner()
        if let user =  Auth.auth().currentUser , !user.isAnonymous{
            loginOutBtn.title = "Logout"
        }else{
            loginOutBtn.title = "Login"
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        listner.remove()
        categories.removeAll()
        collectionView.reloadData()
    }
    func setCategoriesListner() {
        listner = db.collection("categories").addSnapshotListener({ (snap,error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }else {
                snap?.documentChanges.forEach({ (change) in
                    let data = change.document.data()
                    let category = Category.init(data: data)
                    switch change.type {
                    case.added:
                        self.onDocumentAdded(change: change, category: category)
                    case.modified:
                        self.onDocumentModified(change: change, category: category)
                    case.removed:
                        self.onDocumentRemoved(change : DocumentChange)
                    }
                })
            }
        })
    }
    func onDocumentAdded(change:DocumentChange,category:Category) {
        let newIndex = Int(change.newIndex)
        categories.insert(category, at: newIndex)
        collectionView.insertItems(at: [IndexPath(item: newIndex, section: 0)])
    }
    func onDocumentModified(change: DocumentChange , category: Category) {
        if change.newIndex == change.oldIndex{
        //Item changed , but remained in the same position
        }else{
            
        }
    func onDocumentRemoved(change : DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        categories.remove(at: oldIndex)
        collectionView.deleteItems(at: [IndexPath(item: oldIndex, section: 0)])
    }
    
    fileprivate func presentLoginController() {
        let storyboard = UIStoryboard(name: Storyboard.loginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: StoryboardID.loginVC)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func loginOutClicked(_ sender: Any) {
        guard let user = Auth.auth().currentUser else { return  }
        if user.isAnonymous {
            presentLoginController()
        } else {
            do {
                try Auth.auth().signOut()
                Auth.auth().signInAnonymously { (result , error) in
                    if let error = error {
                        Auth.auth().handleFireAuthError(error: error , vc: self)
                        debugPrint(error)
                        
                    }
                    self.presentLoginController()
                }
            } catch {
                Auth.auth().handleFireAuthError(error: error , vc: self)
                debugPrint(error)
            }
        }
        //        if let _ =  Auth.auth().currentUser {
        ////             we are logedIn
        //            do {
        //                //try Auth.auth().signOut()
        //                presentLoginController()
        //            } catch  {
        //                debugPrint(error.localizedDescription)
        //            }
        //        }else{
        //                presentLoginController()
        //            }
        
    }
    
}

extension HomeVC : UICollectionViewDelegate ,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.CategoryCell, for: indexPath) as? CategoryCell{
            cell.configureCell(category: categories[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellWidth = (width - 30) / 2
        let cellHeight = cellWidth * 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
        performSegue(withIdentifier: Segues.toProducts, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.toProducts {
            if let destination = segue.destination as? ProductsVC {
                destination.category = selectedCategory
            }
        }
    }
}

//MARK:- This is prior code ,left for reference
//    func fetchDocument() {
//        let docRef = db.collection("categories").document("9OktsqoBD0GSZ9ED5RUc")
//
//        listner = docRef.addSnapshotListener { (snap,error) in
//            self.categories.removeAll()
//            guard let data = snap?.data() else {return}
//            let newCategory = Category.init(data: data)
//            self.categories.append(newCategory)
//            self.collectionView.reloadData()
//        }
        //        docRef.getDocument { (snap,error) in
        //            guard let data = snap?.data() else {return}
        //
        //
        //            let newCategory = Category.init(data: data)
        //            self.categories.append(newCategory)
        //            self.collectionView.reloadData()
        //
        //        }
//    }
    
//    func fetchCollection() {
//        let collectionRef = db.collection("categories")
//       listner =  collectionRef.addSnapshotListener { (snap,error) in
//            guard let documents = snap?.documents else {return}
//        print(snap?.documentChanges.count)
//
//            self.categories.removeAll()
//            for documents in documents {
//                let data = documents.data()
//                let newCategory = Category.init(data: data)
//                self.categories.append(newCategory)
//            }
//            self.collectionView.reloadData()
//        }
        //        collectionRef.getDocuments { (snap ,error) in
        //            guard let documents = snap?.documents else {return}
        //            for documents in documents {
        //                let data = documents.data()
        //                let newCategory = Category.init(data: data)
        //                self.categories.append(newCategory)
        //            }
        //            self.collectionView.reloadData()
        //        }
//    }
