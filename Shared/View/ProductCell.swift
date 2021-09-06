//
//  ProductCell.swift
//  Artable
//
//  Created by Thinkitive on 04/09/21.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImg: RoundedImageViews!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(product:Product) {
        productTitle.text = product.name
        if let url = URL(string: product.imageUrl) {
            productImg.kf.setImage(with: url)
        }
    }
  
    @IBAction func addtoCartClicked(_ sender: Any) {
    }
    @IBAction func favoriteClicked(_ sender: Any) {
    }
    
}
