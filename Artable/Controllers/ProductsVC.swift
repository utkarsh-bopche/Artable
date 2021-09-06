//
//  ProductsVC.swift
//  Artable
//
//  Created by Thinkitive on 04/09/21.
//

import UIKit
import FirebaseFirestore

class ProductsVC: UIViewController {

    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- Variables
    var products = [Product]()
    var category: Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let product = Product(name: "Landscape", id: "dfd", category: "Nature", price: 24.99, productDescription: "What A Lovely landscape", imageUrl: "https://images.unsplash.com/photo-1516298773066-c48f8e9bd92b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8bGFuZHNjYXBlc3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60", timeStamp: Timestamp(), stock: 0, favorite: false)
        products.append(product)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Identifiers.Productcell, bundle: nil), forCellReuseIdentifier: Identifiers.Productcell)
    }
    



}
extension ProductsVC:UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Productcell, for: indexPath) as? ProductCell{
            cell.configureCell(product: products[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
